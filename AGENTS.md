# AGENTS.md

This repo is Infrastructure-as-Code for a non-production SOC environment (edge firewall, hypervisor, backup appliance, Windows, SIEM platform, case management platform/analysis platform, threat intel platform, automation platform, dashboard UI).
Agents must prioritize: **safety**, **reproducibility**, **minimal diffs**, and **validation hooks**.

## Operating Principles

1. **Small, reviewable changes**
   - Prefer multiple small commits over one large commit.
   - Aim for one feature per commit; include doc updates for new automation entry points.
   - Avoid drive-by refactors.

2. **Safety first**
   - Default to “lab-only” posture; never propose anything that weakens real environments.
   - Any “weakening” is allowed only as an explicit *test posture* with clear revert steps.

3. **Idempotent automation**
   - Ansible tasks must be idempotent.
   - Use check mode where practical; avoid shell unless needed.
   - If shell is used, justify it in comments and ensure safe guards.

4. **Document + validate**
   - For every new automation entry point, add:
     - a doc page or doc section describing intent
     - expected signals/telemetry
     - a validation checklist (what to check, where to check it)
     - a validation artifact (e.g., `docs/logs/blueprint-validate-YYYYMMDD-HHMMSS.log`) and link it in `docs/progress.md` when you run validation

5. **Context hygiene**
   - Keep context small: read only needed files/sections and summarize long outputs.
   - Prefer `rg` for search; avoid pasting large logs into chat unless requested.

6. **No secrets**
   - Never commit secrets, tokens, private keys, password hashes, or exports containing them.
   - Prefer `.env.example`, `group_vars/*example*`, or `vault` references with placeholders.

## Repo Conventions

### Ansible
- Prefer roles for reusable components; playbooks as orchestration.
- Use consistent naming and tagging:
  - `tags: [posture, validate, social, soc]` (adjust as needed)
- Separate “apply” and “revert” behaviors:
  - Either separate playbooks or a `state: present/absent` variable pattern.
- Provide a `vars:` stub and clearly document required variables.
- For posture playbooks, use `posture_action` with `apply|revert` (avoid alternate names).

### Docs
- Use `docs/*.md` with:
  - Purpose
  - Preconditions
  - Steps to run
  - Validation checklist
  - Rollback/revert guidance
- Keep language crisp and “operator-ready.”

### Scripts
- Scripts should be:
  - `set -euo pipefail`
  - lintable
  - non-interactive unless explicitly required
  - documented in a nearby doc or README section

## How to Work a Task (Required)

For each task you are asked to do:

1. **Check working tree**
   - Note existing uncommitted changes; keep new commits scoped to the task.

2. **Read relevant repo context**
   - Scan `README`, `docs/*`, and any referenced playbooks/scripts.
3. **Propose file-level plan in the PR description**
   - Bullet list of files touched + why.
4. **Implement minimal solution**
   - Avoid unrelated changes.
5. **Add validation**
   - Document “how to know it worked” and “how to revert.”
6. **Run local checks when possible**
   - `ansible-lint` (if configured), YAML linting, shellcheck where applicable.

## Social Engineering Posture Work (Special Rules)

We model “social-engineering–induced posture drift” as testable postures. These are **explicitly unsafe in real environments** and must be treated as controlled lab scenarios.

When adding posture tests:
- Always include:
  - clear WARNING banner in docs and playbooks
  - expected detection signals (SIEM platform/case management platform/edge firewall/hypervisor logs, etc.)
  - revert steps and/or a paired revert playbook
- Keep each posture isolated and reversible.
- Prefer toggles based on variables; avoid hard-coded users/hosts.

## Purple Team Certification Lab (External Repo)

We also maintain a **separate** repository for the phase-driven purple-team certification lab
(MITRE kill-chain coverage with SIEM platform-only detections). This repo should **not** house that
code directly; instead, link to it in docs when needed.

If asked to integrate, do **only** these in this repo:
- Add a plan doc pointer to the external repo.
- Add a dashboard link to the lab’s README (no scripts, decoders, or rules here).

Reason: keep SOC/infra IaC stable while the purple-team lab evolves independently.

## Current Roadmap Item: Social Engineering Postures (Top 12)

Create documentation + scaffolding for 12 posture tests under:
- `docs/social-engineering-postures.md`
- `ansible/postures/social_engineering/`
- Update `docs/soc-stack-plan.md` to link the new plan section.

Posture list (canonical names):
1) Reduced MFA coverage  
2) Over-privileged user promotion  
3) Email security relaxation (safe sender / filter bypass)  
4) Execution policy weakening (scripts/macros)  
5) Endpoint protection exclusions  
6) Password policy relaxation / reuse enablement  
7) VPN trust expansion (new principal/device; split tunneling)  
8) Firewall “temporary allow” rules / IDS bypass  
9) Backup & recovery suppression (disable jobs/alerts)  
10) Service account credential exposure / secrets in plaintext  
11) Logging/alert fatigue suppression (mute/reduce telemetry)  
12) Change control bypass / implicit trust in internal requests  

Each posture should have:
- a placeholder playbook file
- a short doc section: what changes, social pretext, attacker reliance, signals, validation, revert

## Output Expectations

When you finish:
- Summarize changes by file.
- Call out any assumptions.
- Provide exact commands to run validation (or where to find them in docs).
