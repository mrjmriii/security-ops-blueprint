# SOC Stack Plan (lab.example.net)

## Purpose
- Deliver a reproducible SOC stack aligned to `docs/vision.md`.
- Keep signal flow observable and reversible through validation.

## Scope
- Deployment model C (hybrid): SIEM on its own VM; case management + analysis + automation on one VM; threat intel on its own VM.
- LAN-only exposure.
- TLS everywhere using the internal CA (per-host certs, no wildcard by default).
- Temporary log retention: 7 days across the stack (revisit once stable).
- All hosts stay on DHCP with edge firewall static reservations and DNS overrides.
- Domain join for SOC Linux hosts and Windows workstations under `lab.example.net`.
- SIEM agents on all endpoints after the stack is stable.
- Dashboard UI hosted on the SOC host (no containers required).

## Dependencies
- Hypervisor reachable with adequate resources for SOC VMs.
- Edge firewall DNS/DHCP overrides in place for lab domain.
- Internal CA available for TLS issuance and trust distribution.
- Directory services reachable for domain joins and LDAP integration.
- Package repositories reachable from SOC hosts.

## Risks
- Search backend compatibility drift or resource contention.
- TLS trust gaps if CA distribution lags host provisioning.
- Under-sized storage for logs/indices (retention failures).
- Over-privileged API keys in runtime paths.

## Validation
- Run the blueprint validation playlist.
- Confirm API status for SIEM/case management/analysis/threat intel.
- Verify alert routing and enrichment in the case management UI.

## Inventory and Sizing (baseline guidance)
- `dc-01.lab.example.net` (directory services + DNS)
  - 2 vCPU / 4-8 GB RAM / 80 GB disk
- `ws-01.lab.example.net` and `ws-02.lab.example.net` (workstations)
  - 2 vCPU / 4-8 GB RAM / 64-80 GB disk
- `siem-01.lab.example.net` (SIEM core + dashboard)
  - 8 vCPU / 16 GB RAM / 150-200 GB disk
- `soc-01.lab.example.net` (case mgmt + analysis + automation)
  - 8 vCPU / 16 GB RAM / 200 GB disk
- `intel-01.lab.example.net` (threat intel)
  - 4 vCPU / 8-16 GB RAM / 100 GB disk

## DNS/DHCP Plan (edge firewall)
- DHCP static reservations for all hosts.
- DNS host overrides for all hosts under `example.net`.
- Domain override for `lab.example.net` to `dc-01`.
- DHCP search list: `lab.example.net`, `example.net`.

## TLS Plan
- Use CA from `ca-01` to issue service certs.
- Install CA trust on all hosts and endpoints.
- Enforce HTTPS for SIEM, case management, analysis, threat intel, and automation UIs.
- Keep `ca-01` off except during issuance/rotation.

## Identity + SSO Plan
- Use directory services (LDAP-compatible) for SIEM, case management, analysis, and threat intel authentication.
- Groups:
  - `SOC-Admins` (admin)
  - `SOC-Analysts` (read/write)
  - `SOC-Viewers` (read-only)
- Service account for LDAP bind (lab-only).

## Deployment Order
Requested order: 3 -> 1 -> 2 (integration prep, core install, then identity/SSO).

Phase 3 (prep):
- Confirm versions + inventory values before running installs.

Phase 1 (core install):
1) Provision VMs with stable LTS images.
2) Bring up `dc-01` and configure directory services + DNS.
3) Join `ws-01` and `ws-02` to the domain.
4) Join `soc-01`, `siem-01`, `intel-01` to the domain.
5) Issue SOC TLS leaf certs and install CA trust.
6) Install SIEM on `siem-01`.
7) Install case management + analysis + automation on `soc-01`.
8) Install threat intel on `intel-01`.
9) Integrations: case mgmt <-> analysis, case mgmt <-> threat intel, SIEM -> automation -> case mgmt.
10) Retention policy applied (7 days).

Phase 2 (identity/SSO):
- Configure LDAP/SSO across SIEM, case management, analysis, and threat intel.

## Agent Rollout (future)
- Deploy SIEM agents to all endpoints after stack stabilization.
- Confirm agent policy, enrollment, and TLS trust first.
- Monitoring details live in: `docs/soc-monitoring-plan.md`

## Social Engineering Posture Tests
We model social-engineering-induced drift as **lab-only validation scenarios** (not recommendations). These postures are designed to exercise detection + response and to validate our controls.

See: `docs/social-engineering-postures.md`
