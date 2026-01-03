# Personal Services Plan (example.net)

## Purpose
Stand up personal services (personal cloud, document archive, AI workstation) that run
when the lab is down, without diluting SOC safety or reproducibility.

## Scope (planned)
- Personal cloud: `personal-cloud-01.example.net`
- Document archive: `document-archive-01.example.net`
- AI workstation: `ai-workstation-01.example.net` (GPU passthrough)

## Dependencies
- Hypervisor resources available for personal services VMs.
- Edge firewall DNS/DHCP overrides configured for the domain.
- Internal CA available for TLS issuance and trust distribution.
- Storage capacity for documents and model data.

## Risks
- Resource contention with SOC lab workloads.
- Data loss without backup coverage or retention.
- GPU passthrough conflicts with other VMs.

## Networking + DNS
- Services live on the bootstrap LAN: `192.0.2.0/24`.
- Static DHCP reservations + DNS host overrides in edge firewall.
- Proposed IPs:
  - `personal-cloud-01`: 192.0.2.228
  - `document-archive-01`: 192.0.2.229
  - `ai-workstation-01`: 192.0.2.231
- TLS everywhere using the internal CA (no wildcard by default).

## Resource sizing (initial)
- Personal cloud:
  - 4 vCPU / 8-16 GB RAM / 200 GB disk (SSD preferred)
- Document archive:
  - 2-4 vCPU / 4-8 GB RAM / 100 GB disk + document storage
- AI workstation:
  - 8-12 vCPU / 32 GB RAM / 300 GB disk
  - GPU passthrough: lab GPU (as available)

## GPU passthrough plan (hypervisor)
- Enable IOMMU on the hypervisor host (GRUB + kernel params).
- Bind the GPU to `vfio-pci` on the host.
- Use OVMF (UEFI) + Q35 machine type in the VM.
- Attach `hostpci0` for the GPU and its audio function.
- Validate inside guest: `nvidia-smi` and CUDA availability.

## Power modes
- `lab_mode`: SOC + RedTeamLab + vulnerable targets.
- `personal_mode`: personal cloud + document archive + AI workstation.
- Switch modes with `ansible/playbooks/blueprint_power_profiles.yml`.

## Planned automation (future)
- VM provisioning playbooks (placeholder)
- Service install playbooks (placeholder)

## Validation checklist
- DNS: `dig personal-cloud-01.example.net` / `document-archive-01.example.net` / `ai-workstation-01.example.net`.
- TLS: browser shows trusted cert from the internal CA.
- Personal cloud UI loads and responds (HTTP 200/302).
- Document archive UI loads and responds (HTTP 200/302).
- AI workstation services respond on expected ports.

## Rollback
- Stop personal VMs (switch back to lab mode).
- Remove edge firewall host overrides + DHCP reservations if decommissioned.
- Revert TLS certs via your internal PKI playbook if needed.
