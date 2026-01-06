# Validation Playlist: SOC Services

## Purpose
Verify SOC service reachability and integration health for SIEM, case
management, analysis, threat intel, and automation.

## Preconditions
- SOC services are installed and reachable.
- Internal CA is installed on the controller.
- Optional API keys exported as environment variables:
  - `CASE_API_KEY`
  - `ANALYSIS_API_KEY`
  - `INTEL_API_KEY`
  - `AUTOMATION_API_KEY`
  - `SIEM_API_TOKEN` or `SIEM_API_USER` + `SIEM_API_PASSWORD`

## Steps to run
```bash
scripts/validate-soc.sh
```

Optional API-key run:
```bash
CASE_API_KEY=... ANALYSIS_API_KEY=... INTEL_API_KEY=... \
AUTOMATION_API_KEY=... SIEM_API_TOKEN=... \
scripts/validate-soc.sh
```

## Expected signals/telemetry
- API mode returns `200` for status endpoints when keys are provided.
- Web mode returns `200/302` (healthy) or `401/403` (auth required).
- Log file saved under `docs/logs/`.

## Validation checklist
- Script output shows `OK` for API checks when keys are provided.
- Web checks show `OK` or `AUTH` rather than `FAIL`.
- Confirm SIEM alert -> case management ingestion on a test alert.
- Confirm analysis and threat intel enrichment on a test observable.

## Rollback/Revert
Not applicable (read-only checks). If a service fails, review its service logs
and re-apply the integration playbook if needed.
