# Edge DNS Filtering Baseline (Blueprint)

## Purpose
- Describe a lab-safe DNS filtering posture at the edge.
- Reduce exposure to known malicious domains while capturing telemetry.

## Preconditions
- Edge DNS resolver or firewall DNS forwarder is reachable.
- Threat feed sources and allowlists defined in variables.
- DNS logs forwarded to the SIEM pipeline.

## Steps to run
1) Apply the baseline:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall`

## Expected signals/telemetry
- DNS filter service running with active blocklists.
- Block events logged for test domains.
- DNS telemetry visible in the SIEM platform.

## Validation checklist
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml edge_firewall -m shell -a "service dns-filter status"`
- Query a known test domain and confirm block behavior.
- Confirm blocked event in the SIEM UI.

## Rollback
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_state=absent`
