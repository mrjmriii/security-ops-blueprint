#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${LOG_DIR:-${ROOT_DIR}/docs/logs}"
OUT_FILE="${OUT_FILE:-${LOG_DIR}/edge-validate-$(date +%Y%m%d-%H%M%S).log}"
NO_LOG="${NO_LOG:-}"

EDGE_HOST="${EDGE_HOST:-edge-fw-01.example.net}"
EDGE_USER="${EDGE_USER:-ansible}"
SSH_OPTS="${SSH_OPTS:--o BatchMode=yes -o ConnectTimeout=5}"

EDGE_IDS_LOG_PATH="${EDGE_IDS_LOG_PATH:-/var/log/ids/alerts.log}"
EDGE_DNS_FILTER_LOG_PATH="${EDGE_DNS_FILTER_LOG_PATH:-/var/log/dns-filter/dns-filter.log}"
EDGE_SYSLOG_HOST_CMD="${EDGE_SYSLOG_HOST_CMD:-}"

if [[ -n "${NO_LOG}" ]]; then
  OUT_FILE=""
fi

if [[ -n "${OUT_FILE}" ]]; then
  mkdir -p "$(dirname "${OUT_FILE}")"
  exec > >(tee "${OUT_FILE}") 2>&1
fi

if ! command -v ssh >/dev/null 2>&1; then
  echo "Missing dependency: ssh"
  exit 1
fi

if [[ -n "${OUT_FILE}" ]]; then
  echo "Log: ${OUT_FILE}"
fi

ssh_try() {
  ssh ${SSH_OPTS} "${EDGE_USER}@${EDGE_HOST}" "$@"
}

check_file() {
  local label="$1"
  local path="$2"
  local status="SKIP"
  local detail="not configured"
  local tail_cmd=""

  if [[ -z "${path}" ]]; then
    printf "%-22s %-6s %s\n" "${label}" "${status}" "${detail}"
    return 0
  fi

  status="FAIL"
  detail="missing or no access"
  if ssh_try "test -f ${path}" >/dev/null 2>&1; then
    status="OK"
    detail="present"
    tail_cmd="tail -n 1 ${path}"
  elif ssh_try "sudo -n test -f ${path}" >/dev/null 2>&1; then
    status="OK"
    detail="present (sudo)"
    tail_cmd="sudo -n tail -n 1 ${path}"
  fi

  printf "%-22s %-6s %s\n" "${label}" "${status}" "${detail}"
  if [[ "${status}" == "OK" && -n "${tail_cmd}" ]]; then
    local last_line
    last_line=$(ssh_try "${tail_cmd}" 2>/dev/null || true)
    if [[ -n "${last_line}" ]]; then
      echo "  last: ${last_line}"
    fi
  fi
}

echo "== Edge validation ($(date -Iseconds)) =="
echo "Edge firewall: ${EDGE_USER}@${EDGE_HOST}"
echo

if ! ssh_try "true" >/dev/null 2>&1; then
  echo "SSH: FAIL (unable to connect)"
  exit 0
fi

printf "%-22s %-6s %s\n" "CHECK" "STATUS" "DETAIL"
printf "%-22s %-6s %s\n" "-----" "------" "------"

check_file "ids alerts log" "${EDGE_IDS_LOG_PATH}"
check_file "dns filter log" "${EDGE_DNS_FILTER_LOG_PATH}"

if [[ -n "${EDGE_SYSLOG_HOST_CMD}" ]]; then
  if output=$(ssh_try "${EDGE_SYSLOG_HOST_CMD}" 2>/dev/null); then
    printf "%-22s %-6s %s\n" "syslog host" "OK" "${output:-unset}"
  else
    printf "%-22s %-6s %s\n" "syslog host" "FAIL" "command error"
  fi
else
  printf "%-22s %-6s %s\n" "syslog host" "SKIP" "set EDGE_SYSLOG_HOST_CMD"
fi
