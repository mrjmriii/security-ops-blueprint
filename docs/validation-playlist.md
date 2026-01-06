# Validation Playlists

## Purpose
Provide repeatable, topic-scoped validation runs with consistent logging and
evidence capture.

## Playlists
- Core connectivity (DNS/PING/HTTPS/TLS): `scripts/validate-blueprint.sh`
  - Runbook: [docs/validation/core.md](./validation/core.md)
- SOC services + integrations: `scripts/validate-soc.sh`
  - Runbook: [docs/validation/soc.md](./validation/soc.md)
- Edge controls: `scripts/validate-edge.sh`
  - Runbook: [docs/validation/edge.md](./validation/edge.md)
- Windows remote management: `scripts/validate-windows-remote.sh`
  - Runbook: [docs/validation/windows-remote.md](./validation/windows-remote.md)
- Remote access connector: `scripts/validate-remote-access.sh`
  - Runbook: [docs/validation/remote-access.md](./validation/remote-access.md)

## Logging
- Each playlist writes a time-stamped log under `docs/logs/`.
- Override the log path with `OUT_FILE=docs/logs/<topic>-validate-YYYYMMDD-HHMMSS.log`.
- Disable logging with `NO_LOG=1`.

## Evidence
- Record validation runs in `docs/progress.md` with the command + log path.
