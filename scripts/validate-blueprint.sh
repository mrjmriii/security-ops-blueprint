#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${LOG_DIR:-${ROOT_DIR}/docs/logs}"
CA_FILE="${CA_FILE:-/usr/local/share/ca-certificates/internal-root-ca.crt}"
OUT_FILE="${OUT_FILE:-${LOG_DIR}/blueprint-validate-$(date +%Y%m%d-%H%M%S).log}"
NO_LOG="${NO_LOG:-}"

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

if [[ -n "${OUT_FILE}" ]]; then
  echo "Log: ${OUT_FILE}"
fi

dns_check() {
  local host="$1"
  if getent hosts "${host}" >/dev/null 2>&1; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

ping_check() {
  local ip="$1"
  if ping -c1 -W1 "${ip}" >/dev/null 2>&1; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

https_check() {
  local url="$1"
  local status
  if status=$(curl --silent --show-error --max-time 5 --cacert "${CA_FILE}" -o /dev/null -w "%{http_code}" "${url}"); then
    echo "${status} OK"
  else
    status=$(curl --silent --show-error --max-time 5 -k -o /dev/null -w "%{http_code}" "${url}" || echo "ERR")
    echo "${status} UNTRUSTED"
  fi
}

tls_check() {
  local url="$1"
  local host port verify
  host=$(echo "${url}" | awk -F[/:] '{print $4}')
  port=$(echo "${url}" | awk -F[/:] '{print ($5 ? $5 : 443)}')
  verify=$(echo | timeout 5 openssl s_client -connect "${host}:${port}" -servername "${host}" -CAfile "${CA_FILE}" 2>/dev/null | awk -F': ' '/Verify return code/ {print $2}')
  if [[ "${verify:-}" == "0 (ok)" ]]; then
    echo "OK"
  elif [[ -z "${verify:-}" ]]; then
    echo "FAIL"
  else
    echo "BAD"
  fi
}

echo "== Blueprint validation ($(date -Iseconds)) =="
echo "CA: ${CA_FILE}"
echo

printf "%-16s %-6s %-6s %-14s %-6s\n" "NAME" "DNS" "PING" "HTTPS" "TLS"
printf "%-16s %-6s %-6s %-14s %-6s\n" "----" "---" "----" "-----" "---"

while read -r name host ip url; do
  [[ -z "${name}" ]] && continue
  dns=$(dns_check "${host}")
  ping=$(ping_check "${ip}")
  https=$(https_check "${url}")
  tls=$(tls_check "${url}")
  printf "%-16s %-6s %-6s %-14s %-6s\n" "${name}" "${dns}" "${ping}" "${https}" "${tls}"
done <<'EOF'
edge-firewall  edge-fw-01.example.net     192.0.2.1   https://edge-fw-01.example.net
hypervisor     hypervisor-01.example.net  192.0.2.240 https://hypervisor-01.example.net:8006
backup         backup-01.example.net      192.0.2.230 https://backup-01.example.net:8007
siem           siem.lab.example.net    192.0.2.225 https://siem.lab.example.net:5601
case-mgmt      cases.lab.example.net   192.0.2.226 https://cases.lab.example.net
analysis       analysis.lab.example.net 192.0.2.226 https://analysis.lab.example.net
automation     automate.lab.example.net 192.0.2.226 https://automate.lab.example.net
dashboard      dash.lab.example.net    192.0.2.226 https://dash.lab.example.net
threat-intel   intel.lab.example.net   192.0.2.227 https://intel.lab.example.net
EOF

echo
echo "DNS spot checks:"
for name in \
  dc-01.lab.example.net ws-01.lab.example.net ws-02.lab.example.net dash.lab.example.net \
  mail-01.example.net tools-01.example.net ca-01.example.net
do
  printf "  %-28s %s\n" "${name}" "$(dns_check "${name}")"
done
