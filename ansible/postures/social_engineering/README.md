# Social Engineering Postures (Lab)

These are **lab-only** posture scenarios for testing detection + response. They are **not recommendations**.

Docs: `docs/social-engineering-postures.md`

## Run
```
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/postures/social_engineering/01_mfa_relaxation.yml -e posture_action=apply
```

Revert:
```
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/postures/social_engineering/01_mfa_relaxation.yml -e posture_action=revert
```

## Posture Index
- `01_mfa_relaxation.yml` - Reduced MFA coverage
- `02_privilege_promotion.yml` - Over-privileged user promotion
- `03_email_filter_bypass.yml` - Email security relaxation
- `04_execution_policy_weakening.yml` - Execution policy weakening
- `05_edr_exclusions.yml` - Endpoint protection exclusions
- `06_password_policy_relaxation.yml` - Password policy relaxation
- `07_vpn_trust_expansion.yml` - VPN trust expansion
- `08_firewall_temporary_allow.yml` - Firewall temporary allow rules
- `09_backup_suppression.yml` - Backup and recovery suppression
- `10_service_account_exposure.yml` - Service account exposure
- `11_logging_alert_suppression.yml` - Logging and alert suppression
- `12_change_control_bypass.yml` - Change control bypass
