#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

RUNBOOKS=(
  docs/edge-ids-ips.md
  docs/edge-dns-filter.md
  docs/remote-access-connector.md
  docs/windows-remote-management.md
  docs/validation/core.md
  docs/validation/soc.md
  docs/validation/edge.md
  docs/validation/windows-remote.md
  docs/validation/remote-access.md
  docs/telemetry-agent-operations.md
  docs/operator-commands.md
  docs/social-engineering-postures.md
  docs/blueprint-sanitization.md
)

PLANS=(
  docs/soc-stack-plan.md
  docs/soc-monitoring-plan.md
  docs/redteamlab-plan.md
  docs/personal-services-plan.md
  docs/soc-integrations.md
  docs/crypto-agility-plan.md
  docs/power-policy.md
)

RUNBOOK_HEADERS=(
  "## Purpose"
  "## Preconditions"
  "## Steps to run"
  "## Validation checklist"
  "## Rollback/Revert"
)

PLAN_HEADERS=(
  "## Purpose"
  "## Scope"
  "## Dependencies"
  "## Risks"
  "## Validation"
)

missing=0

check_headers() {
  local file="$1"
  shift
  for header in "$@"; do
    if ! rg -q --fixed-strings "$header" "$file"; then
      echo "MISSING: $file -> $header"
      missing=1
    fi
  done
}

for file in "${RUNBOOKS[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "MISSING FILE: $file"
    missing=1
    continue
  fi
  check_headers "$file" "${RUNBOOK_HEADERS[@]}"
done

for file in "${PLANS[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "MISSING FILE: $file"
    missing=1
    continue
  fi
  check_headers "$file" "${PLAN_HEADERS[@]}"
done

if [[ "$missing" -ne 0 ]]; then
  echo "Doc lint failed."
  exit 1
fi

echo "Doc lint OK."
