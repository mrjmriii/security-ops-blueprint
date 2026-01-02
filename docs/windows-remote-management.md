# Windows Remote Management (Blueprint)

## Purpose
- Enforce TLS for Windows remote management in the lab.
- Reduce plaintext management traffic and align with internal PKI.

## Preconditions
- Windows endpoints reachable (routing + DNS in place).
- Internal CA available for certificate issuance.
- Time sync healthy across Windows hosts and the CA.

## Steps to run
1) Apply TLS configuration:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_windows_remote_mgmt_tls.yml --limit windows_endpoints`
2) If bootstrapping, optionally allow temporary validation skip:
   - `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_windows_remote_mgmt_tls.yml --limit windows_endpoints -e winrm_skip_cert_validation=true`

## Expected signals/telemetry
- WinRM listener bound to HTTPS with a valid certificate.
- Windows security logs show management sessions over TLS.

## Validation checklist
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible -i ansible/inventory/hosts.yml windows_endpoints -m ansible.windows.win_ping`
- Confirm WinRM listener is HTTPS-only on the host.

## Rollback
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_windows_remote_mgmt_tls.yml --limit windows_endpoints -e winrm_tls_state=absent`
