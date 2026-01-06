#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${LOG_DIR:-${ROOT_DIR}/docs/logs}"
CA_FILE="${CA_FILE:-/usr/local/share/ca-certificates/internal-root-ca.crt}"
OUT_FILE="${OUT_FILE:-${LOG_DIR}/soc-validate-$(date +%Y%m%d-%H%M%S).log}"
NO_LOG="${NO_LOG:-}"

CASE_URL="${CASE_URL:-https://cases.lab.example.net}"
ANALYSIS_URL="${ANALYSIS_URL:-https://analysis.lab.example.net}"
INTEL_URL="${INTEL_URL:-https://intel.lab.example.net}"
AUTOMATION_URL="${AUTOMATION_URL:-https://automate.lab.example.net}"
SIEM_URL="${SIEM_URL:-https://siem.lab.example.net:5601}"

CASE_API_URL="${CASE_API_URL:-${CASE_URL}/api/status}"
ANALYSIS_API_URL="${ANALYSIS_API_URL:-${ANALYSIS_URL}/api/status}"
INTEL_API_URL="${INTEL_API_URL:-${INTEL_URL}/api/status}"
AUTOMATION_API_URL="${AUTOMATION_API_URL:-${AUTOMATION_URL}/api/status}"
SIEM_API_URL="${SIEM_API_URL:-${SIEM_URL}/api/status}"

if [[ -n "${NO_LOG}" ]]; then
  OUT_FILE=""
fi

if [[ -n "${OUT_FILE}" ]]; then
  mkdir -p "$(dirname "${OUT_FILE}")"
  exec > >(tee "${OUT_FILE}") 2>&1
fi

if [[ ! -f "${CA_FILE}" ]]; then
  echo "Missing CA file: ${CA_FILE}"
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "Missing dependency: curl"
  exit 1
fi

if [[ -n "${OUT_FILE}" ]]; then
  echo "Log: ${OUT_FILE}"
fi

curl_status() {
  local url="$1"
  shift
  local status
  if status=$(curl --silent --show-error --max-time 5 --cacert "${CA_FILE}" -o /dev/null -w "%{http_code}" "$@" "${url}"); then
    echo "${status}"
  else
    echo "ERR"
  fi
}

public_result() {
  local status="$1"
  case "${status}" in
    200|301|302) echo "OK" ;;
    401|403) echo "AUTH" ;;
    303|307|308) echo "WARN" ;;
    ERR|000) echo "FAIL" ;;
    *) echo "WARN" ;;
  esac
}

api_result() {
  local status="$1"
  if [[ "${status}" == "200" ]]; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

echo "== SOC validation ($(date -Iseconds)) =="
echo "CA: ${CA_FILE}"
echo

printf "%-12s %-6s %-6s %-6s %s\n" "SERVICE" "MODE" "STATUS" "RESULT" "ENDPOINT"
printf "%-12s %-6s %-6s %-6s %s\n" "-------" "----" "------" "------" "--------"

if [[ -n "${CASE_API_KEY:-}" ]]; then
  status=$(curl_status "${CASE_API_URL}" -H "Authorization: Bearer ${CASE_API_KEY}")
  printf "%-12s %-6s %-6s %-6s %s\n" "case-mgmt" "API" "${status}" "$(api_result "${status}")" "${CASE_API_URL}"
else
  status=$(curl_status "${CASE_URL}")
  printf "%-12s %-6s %-6s %-6s %s\n" "case-mgmt" "WEB" "${status}" "$(public_result "${status}")" "${CASE_URL}"
fi

if [[ -n "${ANALYSIS_API_KEY:-}" ]]; then
  status=$(curl_status "${ANALYSIS_API_URL}" -H "Authorization: Bearer ${ANALYSIS_API_KEY}")
  printf "%-12s %-6s %-6s %-6s %s\n" "analysis" "API" "${status}" "$(api_result "${status}")" "${ANALYSIS_API_URL}"
else
  status=$(curl_status "${ANALYSIS_URL}")
  printf "%-12s %-6s %-6s %-6s %s\n" "analysis" "WEB" "${status}" "$(public_result "${status}")" "${ANALYSIS_URL}"
fi

if [[ -n "${INTEL_API_KEY:-}" ]]; then
  status=$(curl_status "${INTEL_API_URL}" -H "Authorization: ${INTEL_API_KEY}")
  printf "%-12s %-6s %-6s %-6s %s\n" "intel" "API" "${status}" "$(api_result "${status}")" "${INTEL_API_URL}"
else
  status=$(curl_status "${INTEL_URL}")
  printf "%-12s %-6s %-6s %-6s %s\n" "intel" "WEB" "${status}" "$(public_result "${status}")" "${INTEL_URL}"
fi

if [[ -n "${AUTOMATION_API_KEY:-}" ]]; then
  status=$(curl_status "${AUTOMATION_API_URL}" -H "Authorization: Bearer ${AUTOMATION_API_KEY}")
  printf "%-12s %-6s %-6s %-6s %s\n" "automation" "API" "${status}" "$(api_result "${status}")" "${AUTOMATION_API_URL}"
else
  status=$(curl_status "${AUTOMATION_URL}")
  printf "%-12s %-6s %-6s %-6s %s\n" "automation" "WEB" "${status}" "$(public_result "${status}")" "${AUTOMATION_URL}"
fi

if [[ -n "${SIEM_API_TOKEN:-}" ]]; then
  status=$(curl_status "${SIEM_API_URL}" -H "Authorization: Bearer ${SIEM_API_TOKEN}")
  printf "%-12s %-6s %-6s %-6s %s\n" "siem" "API" "${status}" "$(api_result "${status}")" "${SIEM_API_URL}"
elif [[ -n "${SIEM_API_USER:-}" && -n "${SIEM_API_PASSWORD:-}" ]]; then
  status=$(curl_status "${SIEM_API_URL}" -u "${SIEM_API_USER}:${SIEM_API_PASSWORD}")
  printf "%-12s %-6s %-6s %-6s %s\n" "siem" "API" "${status}" "$(api_result "${status}")" "${SIEM_API_URL}"
else
  status=$(curl_status "${SIEM_URL}")
  printf "%-12s %-6s %-6s %-6s %s\n" "siem" "WEB" "${status}" "$(public_result "${status}")" "${SIEM_URL}"
fi
