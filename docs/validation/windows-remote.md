# Validation Playlist: Windows Remote Management

## Purpose
Confirm Windows endpoints are reachable via WinRM and remote management is
stable.

## Preconditions
- WinRM HTTPS is configured on Windows hosts.
- Ansible can reach the `windows_endpoints` inventory group.
- Internal CA is trusted by the controller (for WinRM validation).

## Steps to run
```bash
scripts/validate-windows-remote.sh
```

Optional domain output:
```bash
WIN_VALIDATE_DOMAIN=1 scripts/validate-windows-remote.sh
```

## Expected signals/telemetry
- `ansible.windows.win_ping` returns success for all Windows hosts.
- Domain output matches the expected directory domain when enabled.
- Log file saved under `docs/logs/`.

## Validation checklist
- All Windows hosts report `pong` from `win_ping`.
- Domain output is consistent with the configured directory domain.
- Follow-up checks in `docs/windows-remote-management.md` if any host fails.

## Rollback/Revert
Not applicable (read-only checks). If remote management is broken, rerun the
TLS bootstrap steps or revert to the last known-good snapshot.
