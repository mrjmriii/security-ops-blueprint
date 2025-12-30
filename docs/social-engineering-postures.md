# Social-Engineering Posture Drift (Lab Scenarios)

## Overview
Social engineering often pushes organizations into making "temporary" exceptions that become long-lived security drift. In this lab, we model those posture shifts as **repeatable, testable infrastructure states** so we can validate detection and response (SIEM platform/case management platform/edge firewall/hypervisor) without guessing what changed.

These scenarios are **lab-only**. They are **not recommendations**. The purpose is to simulate realistic drift and build controls that detect and remediate it.

## Preconditions
- Lab-only environment, isolated from production.
- Ansible inventory targets are defined and reachable.
- Baseline services and logging are running (SIEM platform/case management platform/edge firewall).

## How to run
Each posture has a placeholder playbook under:

```
ansible/postures/social_engineering/
```

Run a posture playbook explicitly when you are ready to model it:

```
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/postures/social_engineering/01_mfa_relaxation.yml -e posture_action=apply
```

## How to revert
Revert the posture when the test is done:

```
ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/postures/social_engineering/01_mfa_relaxation.yml -e posture_action=revert
```

## How to validate
- Use the **Lab Validation Playlist**: `docs/validation-playlist.md`
- Review edge firewall posture checks: `docs/maintenance-bypass.md`
- Correlate SIEM platform alerts with case management platform cases and add response notes.
- Capture evidence (screenshots, logs) and link to the scenario in `docs/progress.md`.

## The 12 Social-Engineering Postures

### 01) Reduced MFA coverage
- **What changes:** MFA disabled or bypassed for a subset of users/apps.
- **Pretext/use case:** "Urgent executive travel issue" / "SSO outage, need access now."
- **Why attackers rely on it:** MFA removal expands credential reuse and phishing success.
- **Expected signals/telemetry:** Auth success without MFA, unusual login IPs, policy exceptions.
- **Remediation/enforcement idea:** Conditional access policy checks + auto-expire exceptions.

### 02) Over-privileged user promotion
- **What changes:** User added to admin or privileged groups.
- **Pretext/use case:** "Need temporary admin for vendor support."
- **Why attackers rely on it:** Lateral movement and durable persistence.
- **Expected signals/telemetry:** directory services group membership change events, privilege escalation alerts.
- **Remediation/enforcement idea:** Just-in-time privileges with expiry and approval.

### 03) Email security relaxation (safe sender / filter bypass)
- **What changes:** Sender or domain allowlisted; attachment filtering relaxed.
- **Pretext/use case:** "Important vendor invoices getting blocked."
- **Why attackers rely on it:** Phishing bypass and payload delivery.
- **Expected signals/telemetry:** Mail gateway allowlist changes, new outbound connections.
- **Remediation/enforcement idea:** Time-boxed allowlists with alerting and review.

### 04) Execution policy weakening (scripts/macros)
- **What changes:** Execution policy lowered; macros enabled.
- **Pretext/use case:** "Legacy tool needs macros/scripts."
- **Why attackers rely on it:** Post-exploitation execution and persistence.
- **Expected signals/telemetry:** Policy changes, script block logging, abnormal process trees.
- **Remediation/enforcement idea:** Constrained language mode + signed script enforcement.

### 05) Endpoint protection exclusions
- **What changes:** AV/EDR exclusion for a path or process.
- **Pretext/use case:** "Tool false-positives; need the exclusion."
- **Why attackers rely on it:** Hides payloads and disables detections.
- **Expected signals/telemetry:** EDR config changes, new unsigned binaries in excluded paths.
- **Remediation/enforcement idea:** Centralized approvals + auto-expiring exclusions.

### 06) Password policy relaxation / reuse enablement
- **What changes:** Longer password age, reduced complexity, reuse allowed.
- **Pretext/use case:** "Helpdesk load is high; users keep forgetting."
- **Why attackers rely on it:** Weak or reused creds enable spray and brute force.
- **Expected signals/telemetry:** GPO changes, authentication anomalies.
- **Remediation/enforcement idea:** Enforce strong policies + self-service reset.

### 07) VPN trust expansion (new principal/device; split tunneling)
- **What changes:** Additional user/device allowed; split-tunnel enabled.
- **Pretext/use case:** "Contractor needs short-term access."
- **Why attackers rely on it:** Low-friction access into internal networks.
- **Expected signals/telemetry:** VPN policy change events, unusual source devices.
- **Remediation/enforcement idea:** Scoped VPN profiles + device posture checks.

### 08) Firewall "temporary allow" rules / IDS bypass
- **What changes:** Allow rule inserted; IDS/IPS bypass for a host.
- **Pretext/use case:** "Patch/update is blocked."
- **Why attackers rely on it:** Undetected access and command/control.
- **Expected signals/telemetry:** edge firewall rule changes, IDS bypass list updates.
- **Remediation/enforcement idea:** Time-boxed rules and automated rollback.

### 09) Backup & recovery suppression
- **What changes:** Backup jobs disabled; notifications silenced.
- **Pretext/use case:** "Storage is full / backup window is noisy."
- **Why attackers rely on it:** Makes recovery harder after ransomware.
- **Expected signals/telemetry:** Job disable events, missing backup run evidence.
- **Remediation/enforcement idea:** Immutable backup policy and alerting on disable.

### 10) Service account credential exposure / secrets in plaintext
- **What changes:** Secrets stored in scripts, configs, or tickets.
- **Pretext/use case:** "Need to share creds quickly for deployment."
- **Why attackers rely on it:** Credential harvesting for persistence.
- **Expected signals/telemetry:** New secrets in files, repo scans, unusual service logins.
- **Remediation/enforcement idea:** Vault-only secrets and secret scanning.

### 11) Logging/alert suppression
- **What changes:** Alerts muted, log levels reduced, or ingest disabled.
- **Pretext/use case:** "Too many false positives."
- **Why attackers rely on it:** Reduces detection chance.
- **Expected signals/telemetry:** SIEM platform rule disablements, log pipeline gaps.
- **Remediation/enforcement idea:** Alert tuning with approvals + baseline checks.

### 12) Change control bypass / implicit trust in internal requests
- **What changes:** Emergency changes without approval or documentation.
- **Pretext/use case:** "Urgent production issue; fix it now."
- **Why attackers rely on it:** Exploits informal processes to push risky changes.
- **Expected signals/telemetry:** Config changes without tickets, audit log gaps.
- **Remediation/enforcement idea:** Mandatory change log + short-lived emergency approvals.
