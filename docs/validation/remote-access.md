# Validation Playlist: Remote Access Connector

## Purpose
Confirm the remote access connector service is healthy and reachable.

## Preconditions
- Hypervisor or connector host reachable via Ansible.
- Connector service installed and enabled on the host.

## Steps to run
```bash
scripts/validate-remote-access.sh
```

Optional target override:
```bash
TARGET_GROUP=hypervisor CONNECTOR_SERVICE=remote-access-connector \
scripts/validate-remote-access.sh
```

## Expected signals/telemetry
- Service reports `active` on the connector host.
- Log file saved under `docs/logs/`.

## Validation checklist
- `systemctl is-active remote-access-connector` returns `active`.
- Connector status is healthy in the admin portal.
- Follow-up checks in `docs/remote-access-connector.md`.

## Rollback/Revert
Not applicable (read-only checks). If the connector is down, re-run the
connector playbook or restore the last known-good snapshot.
