# security-ops-blueprint
Vendor-neutral security operations blueprint for identity, segmentation, telemetry, and validation. This is a sanitized, public-facing companion to a private infrastructure repository. Names, domains, IPs, and tool references are generalized on purpose.

![Security Ops Blueprint overview](assets/blueprint/blueprint-overview.svg)

## Portfolio snapshot
- Target roles: Security Engineer, Junior Security Architect, DevSecOps Generalist
- Design intent: scalable from small business to enterprise without changing core control objectives
- Delivery focus: reproducible automation, validation-first operations, minimal-diff change control

## What you will find here
- Vendor-neutral playbooks that express intent and sequencing
- Operator-ready runbooks, sprint plans, and backlog items with exit criteria
- Validation hooks that describe how to prove the system works
- Pseudotwin sanitation rules that keep the public mirror safe

## How to read it
1. Start with `docs/README.md` for the documentation map
2. Review `docs/vision.md` and `docs/project-planning.md` for intent and delivery model
3. Browse `docs/backlog.md` and `docs/sprints/` for current priorities
4. Skim the playbooks in `ansible/playbooks/` to see the automation scaffolds
5. Cross-check `docs/documentation-standards.md` and `docs/terminology.md`

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

## Evidence of rigor
- Clear delivery model with dependencies, risks, and validation checklists
- CISSP-aligned language across continuity, governance, and operational controls
- Lab-only offensive posture content includes warnings and revert guidance
- Emphasis on repeatable tests and artifacts, not slideware

## Related repositories
- Private infrastructure IaC (restricted): `https://github.com/mrjmriii/iac-homelab`
- Purple-team certification lab (separate track): `https://github.com/mrjmriii/purple-team-certification-lab`

## Public repo hygiene
This repo is intentionally sanitized:
- Internal IPs/domains are mapped to reserved example ranges
- Tool-specific references are replaced with generic roles
- Secrets, tokens, and operational credentials are excluded
- Pseudotwin alignment workflow lives in `docs/pseudotwin-map.md` and `docs/blueprint-sanitization.md`

## AI-assisted note
This repository includes AI-assisted drafting and normalization. All changes are reviewed, edited, and curated before publication.
