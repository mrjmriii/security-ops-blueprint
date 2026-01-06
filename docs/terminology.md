# Terminology (Sanitized)

## Core Terms
- Blueprint (pseudotwin): the sanitized public companion to a private lab repo.
- SOC stack: SIEM + case management + analysis + threat intel + automation.
- Signal flow: detect -> triage -> enrich -> respond.
- Validation playlists: `docs/validation-playlist.md` + `scripts/validate-*.sh`.
- Posture: a lab-only drift scenario used for detection validation.
- Agent: Project Manager, Builder, or Analyst (see `docs/ai-agents.md`).
- Board of Directors: GitHub `main` history (source of truth).

## Conventions
- Mark unsafe or intentionally weak settings as **lab-only**.
- Use least-privilege service keys by default.
- Prefer explicit roles and component names.
