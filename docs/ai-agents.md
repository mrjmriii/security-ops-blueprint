# AI Agent Operating Model (Sanitized)

## Purpose
Define how agents collaborate, communicate, and manage token budgets while
keeping the source of truth in GitHub and the public view in this blueprint.

## Roles
- Project Manager (PM): plans scope, runs ceremonies, approves token overages.
- Builder: implements changes and updates automation.
- Analyst: validates, investigates, and documents results.
- Board of Directors: GitHub `main` and its protected history.
- Public: sanitized blueprint output for external consumers.

## Agent Communications (Standardized)
All agent comms are written as short updates in docs and PRs.

| Signal | Author | Destination | Format |
| --- | --- | --- | --- |
| Planning | PM | `docs/backlog.md` | Add/update backlog entries. |
| Decision | PM | `docs/progress.md` | One-paragraph decision record. |
| Change Request | Builder | PR description | File list + intent + validation. |
| Validation | Analyst | `docs/logs/*` + `docs/progress.md` | Run log + summary. |
| Overage Request | Any | `docs/agent-requests.md` | Template row + justification. |

## RACI (Internal Agent Comms)
| Activity | R | A | C | I |
| --- | --- | --- | --- | --- |
| Backlog intake | PM | PM | Analyst | Board, Public |
| Scope change | PM | Board | Builder, Analyst | Public |
| Implementation | Builder | PM | Analyst | Board |
| Validation | Analyst | PM | Builder | Board |
| Release to `main` | PM | Board | Builder | Public |
| Token overage approval | PM | PM | Analyst | Board |

## Token Budget Plan (Monthly = 100%)
Allocate percentages per agent and enforce overage requests.

| Agent | Monthly Budget |
| --- | --- |
| PM | 15% |
| Builder | 55% |
| Analyst | 20% |
| Reserve (unplanned) | 10% |

Rules:
- Overages require a request in `docs/agent-requests.md`.
- Requests must include reason, impact, and rollback or recovery plan.
- Monthly reset on the first business day.

## Weekly Guardrail
When remaining weekly budget is <= 10%, only accept:
- Urgent + Important items from the Eisenhower matrix.
- Validation or documentation that unblocks production safety.
All other work is deferred to the next cycle.

## Token Overage Request Template
- Date:
- Agent:
- Current usage (%):
- Requested overage (%):
- Justification:
- Impact if denied:
- Mitigation / rollback:
- Approval:

## Ceremonies (PM-Hosted)
- Sprint planning: define scope, size (pizza scale), and exit criteria.
- Async standup: daily update in `docs/progress.md`.
- Review + retro: summarize outcomes and adjust backlog.
- Execution: after planning, agents run with minimal intervention.

## Recommendations To Date (Non-Conflicting)
- Keep `main` as the stable, validated branch; use short-lived topic branches.
- Prefer least-privilege service keys; avoid admin keys in runtime paths.
- Document validation and include logs in `docs/logs/`.
- Use the Eisenhower matrix with waterfall/agile/kanban selection.
- Keep the pseudotwin sanitized and vendor-neutral.

## References
- Backlog: `docs/backlog.md`
- Requests log: `docs/agent-requests.md`
