# Validation Playlist: Edge Controls

## Purpose
Confirm edge telemetry is present (IDS/IPS and DNS filtering) and syslog
forwarding is configured when expected.

## Preconditions
- Edge firewall reachable over SSH as the `ansible` user (or override `EDGE_USER`).
- Passwordless sudo is available for read-only checks (optional but recommended).
- IDS/IPS and DNS filtering are enabled when those checks are expected.

## Steps to run
```bash
scripts/validate-edge.sh
```

Override targets and log paths:
```bash
EDGE_HOST=edge-fw-01.example.net EDGE_USER=ansible \
EDGE_IDS_LOG_PATH=/var/log/ids/alerts.log \
EDGE_DNS_FILTER_LOG_PATH=/var/log/dns-filter/dns-filter.log \
scripts/validate-edge.sh
```

## Expected signals/telemetry
- IDS/IPS alerts log exists when IDS/IPS is enabled.
- DNS filter log exists when DNS filtering is enabled.
- Syslog host is configured when forwarding is enabled.
- Log file saved under `docs/logs/`.

## Validation checklist
- Script output shows `OK` for IDS and DNS logs (if enabled).
- Syslog host check is configured (set `EDGE_SYSLOG_HOST_CMD`) when forwarding is expected.
- Follow-up checks in:
  - `docs/edge-ids-ips.md`
  - `docs/edge-dns-filter.md`

## Rollback/Revert
Not applicable (read-only checks). If telemetry is missing, re-apply the related
edge baseline or revert edge config changes per the runbooks above.
