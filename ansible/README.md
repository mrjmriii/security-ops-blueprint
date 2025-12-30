# Ansible
Vendor-neutral automation scaffolds for the blueprint. These playbooks define intent and sequencing, not product-specific installs.

## Usage
Run from the repo root:
```bash
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/<playbook>.yml
```

## Blueprint playbooks
- `blueprint_edge_firewall.yml` — baseline access control, DHCP/DNS intent, and routing policy.
- `blueprint_hypervisor.yml` — virtualization baseline and management-plane expectations.
- `blueprint_backup.yml` — backup appliance intent and retention placeholders.
- `blueprint_identity.yml` — directory services and internal CA expectations.
- `blueprint_network_segments.yml` — segment definitions, DHCP scopes, and routing intent.
- `blueprint_siem.yml` — SIEM platform baseline and agent intake assumptions.
- `blueprint_case_mgmt.yml` — incident/case management baseline.
- `blueprint_threat_intel.yml` — threat intel platform baseline.
- `blueprint_soar.yml` — automation platform baseline.
- `blueprint_validation.yml` — validation hooks and runbook references.
- `blueprint_power_profiles.yml` — power profile grouping and lifecycle toggles.

## Inventory
`ansible/inventory/hosts.yml` is the canonical inventory. Align it with `data/hosts.yaml` and `data/networks.yaml`.

## Secrets
This repo does not ship secrets. If you implement a vault:
- Copy `ansible/inventory/group_vars/all/vault.yml.example` to `vault.yml`
- Use `ansible-vault` to store credentials and API tokens
