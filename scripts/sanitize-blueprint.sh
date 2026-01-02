#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
INTERNAL_ROOT="${INTERNAL_ROOT:-}"
BLUEPRINT_ROOT="${BLUEPRINT_ROOT:-${ROOT_DIR}}"
MAP_FILE="${MAP_FILE:-${ROOT_DIR}/data/sanitization-map.tsv}"
REPLACEMENTS_FILE="${REPLACEMENTS_FILE:-${ROOT_DIR}/data/sanitization-replacements.tsv}"
DRY_RUN="${DRY_RUN:-1}"

for bin in rg perl; do
  if ! command -v "${bin}" >/dev/null 2>&1; then
    echo "Missing dependency: ${bin}"
    exit 1
  fi
done

if [[ -z "${INTERNAL_ROOT}" ]]; then
  echo "Set INTERNAL_ROOT to the internal repo path."
  exit 1
fi

if [[ ! -f "${MAP_FILE}" ]]; then
  echo "Missing map file: ${MAP_FILE}"
  exit 1
fi

STAGING_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "${STAGING_DIR}"
}
trap cleanup EXIT

copy_count=0
while IFS=$'\t' read -r source dest purpose; do
  [[ -z "${source}" ]] && continue
  [[ "${source}" =~ ^# ]] && continue
  src_path="${INTERNAL_ROOT}/${source}"
  dest_path="${STAGING_DIR}/${dest}"
  if [[ ! -f "${src_path}" ]]; then
    echo "Missing source: ${src_path}"
    exit 1
  fi
  mkdir -p "$(dirname "${dest_path}")"
  cp "${src_path}" "${dest_path}"
  copy_count=$((copy_count + 1))
done < "${MAP_FILE}"

if [[ -f "${REPLACEMENTS_FILE}" ]]; then
  while IFS=$'\t' read -r pattern replacement; do
    [[ -z "${pattern}" ]] && continue
    [[ "${pattern}" =~ ^# ]] && continue
    rg -l "${pattern}" "${STAGING_DIR}" | while read -r file; do
      perl -0pi -e "s/${pattern}/${replacement}/g" "${file}"
    done
  done < "${REPLACEMENTS_FILE}"
fi

private_ip_regex='(10\\.[0-9]{1,3}\\.|192\\.168\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\.)'
if rg -n "${private_ip_regex}" "${STAGING_DIR}" >/dev/null; then
  echo "Private IPs detected after sanitization; update replacements and retry."
  rg -n "${private_ip_regex}" "${STAGING_DIR}"
  exit 1
fi

secret_regex='(BEGIN (RSA|EC|OPENSSH) PRIVATE KEY|AKIA[0-9A-Z]{16})'
if rg -n "${secret_regex}" "${STAGING_DIR}" >/dev/null; then
  echo "Possible secret material detected; review sanitization inputs."
  rg -n "${secret_regex}" "${STAGING_DIR}"
  exit 1
fi

if [[ "${DRY_RUN}" != "0" ]]; then
  echo "DRY_RUN enabled. Staged ${copy_count} files for review."
  exit 0
fi

while IFS=$'\t' read -r source dest purpose; do
  [[ -z "${source}" ]] && continue
  [[ "${source}" =~ ^# ]] && continue
  src_path="${STAGING_DIR}/${dest}"
  dest_path="${BLUEPRINT_ROOT}/${dest}"
  mkdir -p "$(dirname "${dest_path}")"
  cp "${src_path}" "${dest_path}"
done < "${MAP_FILE}"

echo "Sanitized ${copy_count} files into ${BLUEPRINT_ROOT}."
