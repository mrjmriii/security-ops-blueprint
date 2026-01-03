# Power Policy

## Purpose
Keep always-on footprint minimal while ensuring core services stay reachable.

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

## Power controls (hypervisor)
- Start/stop VMs using the hypervisor management UI or CLI.

## Validation
- hypervisor UI shows expected VM states (running/stopped).
- Tag assignments match your power profile plan.

## Rollback
- Switch back to the previous mode using your power profile playbook.
- If tag sync was incorrect, re-run the power profile sync after fixing tag maps.
