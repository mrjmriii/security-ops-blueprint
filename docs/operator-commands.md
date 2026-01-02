# Operator Command Quicklist (Top 12)

## Purpose
- Provide a small, offline-ready command set for common blueprint operations.
- Keep the list short, safe, and reproducible for handover operators.

## Preconditions
- Repo is available at `~/src/security-ops-blueprint` (or set `SECOPS_BLUEPRINT_ROOT`).
- Ansible installed and `ANSIBLE_CONFIG=ansible/ansible.cfg` is used.
- Inventory values are updated from `example.net` placeholders to real hosts before applying.
- SSH access to targets is working (keys in `~/.ssh`).

## Steps to run
Run from the repo root:

1) Blueprint health check (DNS/TLS/HTTP):
   - `scripts/validate-blueprint.sh`
2) Edge firewall baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_firewall.yml`
3) Hypervisor baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_hypervisor.yml`
4) Backup appliance baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_backup.yml`
5) Directory services baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_identity.yml`
6) Network segmentation baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_network_segments.yml`
7) SIEM baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_siem.yml`
8) Case management baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_case_mgmt.yml`
9) Threat intel baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_threat_intel.yml`
10) Automation baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_soar.yml`
11) Validation baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_validation.yml`
12) Power profile switch (lab mode on):
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_power_profiles.yml -e profile_name=lab_mode -e profile_action=start`

## Validation checklist
- `scripts/validate-blueprint.sh`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml all -m ping`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_validation.yml --check`

## Rollback
- Power profiles: rerun with `profile_action=stop`.
- Individual baselines: re-run the same playbook after restoring prior variables.
- Network/DNS changes: revert inventory + variable changes, then re-run `blueprint_edge_firewall.yml`.
