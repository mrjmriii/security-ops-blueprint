# RedTeamLab Plan (PentestNet / HiddenNet / RedTeamLab)

## Purpose
Provide a repeatable, lab-only adversary environment that feeds the SOC
with realistic telemetry without destabilizing core infrastructure.

## Purple Team Certification Lab (external)
The phase-driven purple team certification lab lives in a separate repo:
- https://github.com/mrjmriii/purple-team-certification-lab
This blueprint links to it for planning only (no automation is stored here).

## Scope
- Adversary lab networks and segmented targets.
- Vulnerable targets and lab tooling used for detection validation.
- Telemetry capture for SOC correlation.

## Dependencies
- Internal hypervisor bridges created for lab networks.
- Lab router provisioned with NAT and firewall policy.
- Edge firewall static routes to lab networks applied.
- Telemetry manager reachable for log intake.

## Risks
- Network bleed between lab segments if ACLs drift.
- Resource contention with SOC core services.
- Vulnerable images exposed outside the lab networks.

## Networks
- **PentestNet**: 198.51.100.0/24 (GW 198.51.100.1)
- **HiddenNet**: 203.0.113.0/24 (GW 203.0.113.1)
- **RedTeamLab**: 198.51.100.128/24 (GW 198.51.100.129)

No switch VLAN tagging. Segmentation is implemented via **internal hypervisor bridges**
and a dedicated lab-router VM.

## Routing Model (lab-router-01)
- WAN: `vmbr0` (192.0.2.252/24, GW 192.0.2.1)
- LANs: `vmbr_pentest`, `vmbr_hidden`, `vmbr_redteam`
- NAT from lab networks to edge firewall LAN.
- Inter-LAN blocked by default; explicit allow rules for SOC telemetry and directory services.

## Workloads (generic roles)
- **Adversary workstation** (dual-NIC): PentestNet + RedTeamLab.
- **Vulnerable targets**: PentestNet.
- **Dual-homed target**: PentestNet + HiddenNet.
- **Vulnerable web app bundle**: PentestNet.
- **RADIUS server**: RedTeamLab (for Wi-Fi auth simulations).

## Provisioning Notes
- Use prebuilt images for targets when possible.
- Keep images offline and validated before import.
- Baseline snapshots after provisioning.

## Identity integration (lab-only)
We keep the existing directory services domain (`lab.example.net`) and model
RedTeamLab as an OU + DNS sub-zone (`redteamlab.lab.example.net`).

Required items:
- OU: `RedTeamLab`
- Test clients joined to the domain and placed in the OU.
- **GPO**: disable endpoint protection for RedTeamLab OU (lab-only).
- File shares:
  - `CorporateFileShare` on the directory server.
  - `SharedData` on each client.
- Kerberos lab SPN (example pattern):
  - Register a service principal for a lab service account.
  - Service account: `LAB\\sqladmin`

## SOC Telemetry
All endpoints run SIEM agents. RedTeamLab is a telemetry generator:
web exploits, suspicious UAs, anonymizer activity, malware tests, and identity abuse.

## Snapshots + Profiles
- Baseline snapshots after provisioning.
- Power profiles to start/stop groups (SOC core vs RedTeamLab vs targets).
- Revert-to-good playbook before/after exercises.

## Validation
- Confirm lab networks route only through the lab router.
- Ensure telemetry ingests events from lab targets.
- Run `docs/validation-playlist.md` after bringing targets online.
