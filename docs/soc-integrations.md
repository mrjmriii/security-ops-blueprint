# SOC Integrations (Generic Wiring Notes)

Goal: record integration intent and signal flow so automation is safe to implement later.

## Integration Patterns (baseline)
- **Case management <-> Analysis platform**
  - Configure case management to call analysis APIs for enrichment.
  - Install analyzers/responders appropriate for lab scope.
- **Case management <-> Threat intel platform**
  - Use a LAN-only API key for enrichment and IOC lookup.
- **SIEM -> Automation platform -> Case management**
  - Prefer a webhook-based integration to avoid brittle scripts.
  - Automation platform creates cases/alerts in case management.
- **SIEM -> Threat intel platform (optional)**
  - IOC enrichment only; avoid bi-directional sharing in lab.

## Source Tracking
Track upstream integration sources in a private repo or internal doc:
- Tool version
- Commit/tag pin
- Installation instructions
- Known limitations

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
