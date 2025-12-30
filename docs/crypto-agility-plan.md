# Crypto Agility Plan (Rotation + Hygiene)

Goal: rotate credentials, keys, and certificates safely and predictably without breaking access.

## Scope
- Ansible Vault secrets (endpoints, servers, app creds).
- SSH keys (controller -> hosts).
- TLS leaf certs (remote management, web UIs).
- CA operations (issue new leafs; keep root offline).
- Service passwords (directory services, mail, app accounts).

## Principles
- Time-boxed maintenance windows.
- One class of secret per change set.
- Verify access before and after each phase.
- Keep rollback paths (old certs/keys) until validation passes.

## Phased Rotation
1) **Inventory + dry run**
   - List all secrets/keys/certs in repo and on hosts.
   - Document owners + dependencies.
   - Confirm CA availability (power policy).

2) **Credential rotation (apps + users)**
   - Rotate app passwords in Vault.
   - Apply playbooks, validate services.
   - Rotate directory services admin + recovery credentials.

3) **TLS leaf rotation**
   - Power on `ca-01`, issue new leaf certs.
   - Deploy to services (remote management, SIEM platform, case management platform, threat intel platform, mail).
   - Validate TLS from controller and clients.

4) **SSH key rotation**
   - Generate new controller keypair.
   - Update authorized_keys on hosts.
   - Update `~/.ssh/config` or inventory key paths.

5) **Clean-up + record**
   - Remove old keys/certs once verified.
   - Update docs/progress + vault notes.

## Implementation Notes
- Use playbooks per subsystem (endpoints, servers, edge firewall) rather than one mega-play.
- Keep `ca-01` offline except during issuance.
- Prefer staged rollouts: lab -> SOC -> infra.

## Future Automation Ideas
- `ansible/playbooks/crypto_rotate_windows.yml`
- `ansible/playbooks/crypto_rotate_linux.yml`
- `ansible/playbooks/crypto_rotate_tls.yml`
- `ansible/playbooks/crypto_rotate_ssh.yml`

## Status
- Draft only. Implement incrementally.
