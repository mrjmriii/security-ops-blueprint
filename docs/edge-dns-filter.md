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
2) (Optional) Apply a DNS sinkhole VIP:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_sinkhole_vip_state=present`
3) (Optional) Apply log volume limits:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_log_limits='{max_events: 5000, max_errors: 500}'`
4) (Optional) Apply bypass CIDRs for internal services:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_bypass_cidrs='[\"198.18.0.0/24\"]'`

## Expected signals/telemetry
- DNS filter service running with active blocklists.
- Block events logged for test domains.
- DNS telemetry visible in the SIEM platform.
- Edge firewall config audit log shows DNS filter, sinkhole VIP, or allowlist updates.
- DNS filter logs rotate at configured limits without flooding the pipeline.

## Validation checklist
- `scripts/validate-edge.sh`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml edge_firewall -m shell -a "service dns-filter status"`
- Query a known test domain and confirm block behavior.
- Confirm blocked event in the SIEM UI.
- Confirm the sinkhole VIP appears on the intended interface when enabled.
- Confirm bypass CIDRs do not generate block events.

## Rollback/Revert
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_state=absent`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_sinkhole_vip_state=absent`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_log_limits={}`
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_edge_dns_filter.yml --limit edge_firewall -e dns_filter_bypass_cidrs=[]`
