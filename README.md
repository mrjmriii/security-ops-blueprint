# security-ops-blueprint
Vendor-neutral security operations blueprint for identity, segmentation, telemetry, and validation. This is a sanitized, public-facing companion to a private infrastructure repository. Names, domains, IPs, and tool references are generalized on purpose.

## Scope
- Edge firewall routing, DHCP/DNS, and access control
- Hypervisor + backup appliance baseline expectations
- Directory services and internal PKI/TLS
- SOC primitives: SIEM, case management, analysis, threat intel, automation
- Network segmentation and lab routing
- Validation-first operations (DNS/TLS/HTTP checks)

## What this is
- A clear, reproducible blueprint with vendor-agnostic playbooks and docs
- A reference for designing reliable signal flow, not just installing tools
- A public artifact that explains intent and sequencing

## What this is not
- A deployment for any specific product
- A complete turn-key install (secrets and vendors live elsewhere)
- A one-size-fits-all SOC cookbook

## Blueprint playbooks
These are vendor-neutral scaffolds that define intent and sequencing:
- `ansible/playbooks/blueprint_edge_firewall.yml`
- `ansible/playbooks/blueprint_hypervisor.yml`
- `ansible/playbooks/blueprint_backup.yml`
- `ansible/playbooks/blueprint_identity.yml`
- `ansible/playbooks/blueprint_network_segments.yml`
- `ansible/playbooks/blueprint_siem.yml`
- `ansible/playbooks/blueprint_case_mgmt.yml`
- `ansible/playbooks/blueprint_threat_intel.yml`
- `ansible/playbooks/blueprint_soar.yml`
- `ansible/playbooks/blueprint_validation.yml`
- `ansible/playbooks/blueprint_power_profiles.yml`

## Documentation
Start with `docs/README.md` for the full index.

## Planning
- Project planning model: `docs/project-planning.md`
- Backlog: `docs/backlog.md`

## Public repo hygiene
This repo is intentionally sanitized:
- Internal IPs/domains are mapped to reserved example ranges.
- Tool-specific references are replaced with generic roles.
- Secrets, tokens, and operational credentials are excluded.
- Pseudotwin alignment workflow lives in `docs/pseudotwin-map.md` and `docs/blueprint-sanitization.md`.

## AI-assisted note
This repository includes AI-assisted drafting and normalization. All changes are reviewed, edited, and curated before publication.
