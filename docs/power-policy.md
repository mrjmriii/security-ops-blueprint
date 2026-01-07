# Power Policy

## Purpose
Keep always-on footprint minimal while ensuring core services stay reachable.

## Scope
- Lab infrastructure (SOC, adversary lab, targets).
- Personal services mode (personal cloud, document archive, AI workstation).
- Backup appliance and CA power practices.

## Dependencies
- Hypervisor reachable for start/stop actions.
- Tags and profiles defined in inventory vars.
- Backups scheduled on the backup appliance before power-down.

## Risks
- Shutting down critical services (DNS/directory services) can break automation.
- Missed backups if the backup appliance is offline during schedules.

## Always on
- edge firewall: firewall, DNS, DHCP, WAN edge.
- hypervisor: virtualization control plane.
- backup appliance: schedule + retention.

## On demand
- ca-01: power on only for certificate issuance/rotation, then shut down.

## Optional/on demand
- mail-01: local-only email; can be powered down if not needed.
- tools-01: security workstation; power on when in use.
- lab-router-01: only needed when RedTeamLab networks are active.
- redteamlab targets: power on for exercises, then shut down.

## Lab vs personal modes
Use mode switching when you want to pause the SOC/RedTeamLab and bring up personal services.

- Profiles live in `ansible/inventory/group_vars/all/power_profiles.yml` (copy from `.example`).
- Tag map lives in `ansible/inventory/group_vars/all/power_tags.yml` (copy from `.example`).

Runbooks:
- Power profiles: `ansible/playbooks/blueprint_power_profiles.yml`

Recommended tags:
- `lab`: all lab VMs (SOC, RedTeamLab, vulnerable targets).
- `personal`: personal cloud, document archive, AI workstation.
- `soc`, `redteam`, `vuln`: finer-grained shutdown control.

## Activity-based power plan
Use this matrix to map operator activity to the minimum required footprint.
Keep changes small and reversible; prefer profiles when possible.

| Activity | Required footprint | Recommended action |
| --- | --- | --- |
| Idle / baseline monitoring | edge firewall, hypervisor, backup appliance | Keep always-on only. |
| SOC operations (triage/response) | Always-on + SIEM + case mgmt + intel | Start SOC profile. |
| Directory services training | SOC operations + directory services + workstations | Start the identity/workstation profile. |
| Adversary lab exercise | SOC operations + lab router + targets | Start red team + target profiles. |
| AI document analysis | Always-on + AI workstation | Start personal services profile. |
| PKI issuance / rotation | Always-on + CA | Start CA on-demand profile; shut down after issuance. |
| Mail alert validation | Always-on + mail service | Start mail profile when testing alerts. |

## Change control (activity switches)
1) Verify dependencies (directory services, CA availability, backup window).
2) Check hypervisor health: avoid starting large profiles if RAM > 85% or swap > 20%.
3) Start the smallest profile that satisfies the activity.
4) Validate via hypervisor UI checks.
5) Record the change in `docs/progress.md` when it affects uptime.

## Power controls (hypervisor)
- Start/stop VMs using the hypervisor management UI or CLI.

## Validation
- hypervisor UI shows expected VM states (running/stopped).
- Tag assignments match your power profile plan.

## Rollback/Revert
- Switch back to the previous mode using your power profile playbook.
- If tag sync was incorrect, re-run the power profile sync after fixing tag maps.
