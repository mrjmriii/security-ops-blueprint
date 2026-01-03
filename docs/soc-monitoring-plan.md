# SOC Monitoring Plan (Endpoint Telemetry + Threat Intel)

## Purpose
Ensure every lab endpoint is monitored and detections are testable, repeatable,
and tied to response workflows in case management platform/analysis platform/threat intel platform.

## Endpoint Coverage (SIEM platform)
All endpoints run SIEM platform agents:
- Core servers: hypervisor, backup appliance, CA, mail, SOC, lab router.
- Adversary lab: adversary workstation + vulnerable targets.
- Directory services: domain controller + workstations.

Group agents by role: `soc`, `redteamlab`, `vulnerable`, `infra`, `workstations`.

## Windows Telemetry
- Process creation auditing with a known-good baseline config.
- Built-in endpoint protection logs forwarded to the SIEM platform.
- Disable endpoint protection **only** in the RedTeamLab OU (lab-only).

## Linux Telemetry
- auth logs + sudo + SSH.
- auditd for process + syscall visibility.
- FIM on:
  - `/etc`, `/usr/local`, `/var/www`, user home dirs
  - web app roots (vulnerable web app bundle)

## Threat Intel + Enrichment
- threat intel platform feeds + org configured.
- SIEM platform -> threat intel platform integration for IOC enrichment.
- analysis platform analyzers enabled (internal intel + external reputation sources).
- case management platform for case management + alert triage.

## Malware Detection
- Signature-based detection rulesets.
- External reputation checks in the SIEM platform.
- EICAR test file in a controlled lab path for validation.
- IOC hash test list (lab-only).

## Test Harness / Purple Team Signals
Lab-only tests to generate detections:
- NIDS test harness for malicious UA / anonymizer indicators.
- APT simulation tools (lab-only).
- Vulnerable web app attack paths.
- Identity abuse simulation (service account + SPN patterns).
- Social-engineering posture drift scenarios:
  - agent offline
  - log file full
  - logging disabled

## Validation
Use `docs/validation-playlist.md` and record artifacts in `docs/progress.md`.

## Notes
- All detections are lab-only.
- Keep SOC stack up even when RedTeamLab targets are off (SOC priority).
