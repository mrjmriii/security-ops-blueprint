# Internal PKI

Scope: lab-only TLS for infrastructure services. Location: `ca-01` VM.

## CA layout
- CA root lives on `ca-01` under `/var/lib/internal-ca`.
- Root key: `/var/lib/internal-ca/private/ca.key`
- Root cert: `/var/lib/internal-ca/certs/ca.crt`
- Issued leaf certs: `/var/lib/internal-ca/issued/*.crt`

## Runbook
Playbook: `ansible/playbooks/blueprint_identity.yml`

```
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_identity.yml
```

Targets issued by default:
- `edge-fw-01.example.net` (edge firewall web UI)
- `hypervisor-01.example.net` (hypervisor web UI)
- `backup-01.example.net` (backup appliance web UI)
- `mail-01.example.net` (SMTP/IMAP TLS)

## Operational posture
- Keep `ca-01` powered off by default; only power it on for certificate issuance/rotation.
- Existing services continue to use their current certs while `ca-01` is off.
- Power control from hypervisor management UI or CLI.

## Client trust
- Controller installs the CA into system trust via `update-ca-certificates`.
- Mail clients may need a manual CA import if they do not use system trust.

## Rotation
- Set `pki_force_issue: true` in your PKI vars file to reissue leaf certs.
- If you want to rotate private keys, delete the leaf key/cert on `ca-01` and rerun the playbook.
