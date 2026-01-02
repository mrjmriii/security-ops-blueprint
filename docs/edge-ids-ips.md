# Edge IDS/IPS Baseline (Blueprint)

## Purpose
- Describe a lab-safe IDS/IPS posture at the edge.
- Ensure alerts flow into the telemetry pipeline for validation.

## Preconditions
- Edge firewall reachable via Ansible.
- Capture interface and alert destination defined in variables.
- Storage allocated for alert logs and packet captures (if enabled).

## Steps to run
1) Apply the baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_ids.yml --limit edge_firewall`

## Expected signals/telemetry
- IDS/IPS service running with active ruleset.
- Alerts generated for known test signatures.
- Telemetry forwarded to the SIEM pipeline.

## Validation checklist
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml edge_firewall -m shell -a "service ids status"`
- Generate a benign test signature and confirm an alert.
- Confirm alert visibility in the SIEM platform UI.

## Rollback
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_ids.yml --limit edge_firewall -e ids_state=absent`
