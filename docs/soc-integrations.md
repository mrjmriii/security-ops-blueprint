# SOC Integrations (Generic Wiring Notes)

## Purpose
Record integration intent and signal flow so automation is safe to implement later.

## Scope
- SIEM, case management, analysis, threat intel, and automation wiring.
- API keys and connector configuration.
- Lab-only validation of alert flow and enrichment.

## Dependencies
- SIEM, case management, analysis, and threat intel services reachable.
- API keys stored in secure vars (vault or secrets manager).
- TLS trust established between SOC components.

## Risks
- Alert flooding if thresholds are too low.
- Over-privileged API keys in runtime paths.
- Version drift between integrations and upstream APIs.

## Validation
- Use the validation checklist in the Automation section.

## Integration Patterns (baseline)
- **SIEM -> Case management (direct)**
  - Push alerts directly into case management with an org-scoped API key.
  - Include an org selector header when multi-tenant is enabled.
- **Case management <-> Analysis platform**
  - Configure case management to call analysis APIs for enrichment.
  - Install analyzers/responders appropriate for lab scope.
- **Case management <-> Threat intel platform**
  - Use a LAN-only API key for enrichment and IOC lookup.
- **Threat intel -> Analysis platform (optional)**
  - Enrich indicators prior to triage; keep write-back disabled in lab.
- **SIEM -> Automation platform -> Case management (optional)**
  - Use automation only if direct alert push is unavailable or brittle.

## Source Tracking
Track upstream integration sources in a private repo or internal doc:
- Tool version
- Commit/tag pin
- Installation instructions
- Known limitations

## Least-privilege posture
- Default to scoped service users with only `manageAlert`-level rights.
- If admin keys are used to unblock alert creation, log a follow-up to
  revert to least privilege once profile assignments are fixed.

## Test Feeds + Telemetry Generators
Use lab-only sources that are safe and documented:
- benign web app targets
- NIDS test harnesses
- synthetic IOC feeds
- sample malware indicators (non-executable)

## Open Questions (track before automation)
- Which integrations are required vs. optional?
- Which systems should remain isolated?
- Which data should never leave the lab?

## Automation entrypoint
### Purpose
- Provide a sanitized automation hook for wiring SOC integrations.

### Preconditions
- API keys stored in secure vars (vault or secrets manager).
- Network routes and TLS trust established between platforms.

### Steps to run
- `ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook ansible/playbooks/blueprint_soc_integrations.yml --limit case_mgmt`

### Expected signals/telemetry
- Alerts land in case management with a consistent source reference.
- Analysis jobs complete and return artifacts in case management.
- Threat intel lookups succeed and return IOC context.

### Validation checklist
- `scripts/validate-soc.sh` (summary API/web status checks)
- Confirm integration status in each platform UI.
- Confirm SIEM alert -> case management ingestion (one test alert).
- Confirm case management -> analysis enrichment on a test observable.
- Confirm threat intel feed sync or lookup succeeds.

### Rollback
- Re-run `blueprint_soc_integrations.yml` with `-e soc_integration_state=absent`.
