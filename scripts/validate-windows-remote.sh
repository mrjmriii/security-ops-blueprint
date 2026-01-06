#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${LOG_DIR:-${ROOT_DIR}/docs/logs}"
OUT_FILE="${OUT_FILE:-${LOG_DIR}/windows-remote-validate-$(date +%Y%m%d-%H%M%S).log}"
NO_LOG="${NO_LOG:-}"

ANSIBLE_CONFIG="${ANSIBLE_CONFIG:-${ROOT_DIR}/ansible/ansible.cfg}"
INVENTORY="${INVENTORY:-${ROOT_DIR}/ansible/inventory/hosts.yml}"
WINDOWS_GROUP="${WINDOWS_GROUP:-windows_endpoints}"

if [[ -n "${NO_LOG}" ]]; then
  OUT_FILE=""
fi

if [[ -n "${OUT_FILE}" ]]; then
  mkdir -p "$(dirname "${OUT_FILE}")"
  exec > >(tee "${OUT_FILE}") 2>&1
fi

if ! command -v ansible >/dev/null 2>&1; then
  echo "Missing dependency: ansible"
  exit 1
fi

if [[ -n "${OUT_FILE}" ]]; then
  echo "Log: ${OUT_FILE}"
fi

echo "== Windows remote management validation ($(date -Iseconds)) =="
echo "Inventory: ${INVENTORY}"
echo "Group: ${WINDOWS_GROUP}"
echo

ANSIBLE_CONFIG="${ANSIBLE_CONFIG}" ansible -i "${INVENTORY}" "${WINDOWS_GROUP}" -m ansible.windows.win_ping

if [[ "${WIN_VALIDATE_DOMAIN:-}" == "1" ]]; then
  ANSIBLE_CONFIG="${ANSIBLE_CONFIG}" ansible -i "${INVENTORY}" "${WINDOWS_GROUP}" \
    -m ansible.windows.win_shell \
    -a "(Get-WmiObject Win32_ComputerSystem).Domain"
fi
