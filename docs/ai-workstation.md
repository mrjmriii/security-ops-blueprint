# AI Workstation Blueprint (Sanitized)

## Purpose
Provide a self-hosted AI workstation that keeps sensitive data local while
supporting controlled, policy-driven access to public information for research.

## Scope
- GPU-backed inference for local models.
- Operator UI for interactive use.
- Automation/orchestration UI for repeatable workflows.
- Research gateway for public-only queries.
- TLS termination and host firewall enforcement.

## Architecture (Vendor-Neutral)
### Core services
- **Local model runtime**: GPU-backed inference service bound to localhost.
- **Operator UI**: web UI for prompt/analysis workflows (fronted by TLS).
- **Automation UI**: workflow engine for document processing and agents.
- **Research gateway**: outbound metasearch interface for public sources only.
- **Reverse proxy**: TLS termination + path/host routing.
- **Host firewall**: allowlist inbound services only.

### Data handling guardrails
- **Sensitive data stays local**: no outbound transfer of PII or confidential
  content.
- **Public-only research**: outbound queries are allowed only when data is
  clearly public and does not contain sensitive fields.
- **Classification gate**: workflows must label inputs as `sensitive` or
  `public`. Only `public` flows may access the research gateway.
- **Telemetry**: disable vendor telemetry by default; keep logs local.

## Host Exposure Model
- All services bind to loopback by default.
- TLS reverse proxy exposes only the intended UI/API endpoints.
- Host firewall restricts inbound traffic to the documented allowlist.
- Outbound egress is constrained by proxy policy and edge firewall rules.

## Resource Sizing (Initial)
- 8-12 vCPU / 32 GB RAM / 300+ GB disk.
- GPU passthrough with adequate VRAM for local inference workloads.
- Dedicated storage for model cache + document artifacts.

## Provisioning Outline
1) Provision a Linux VM on the hypervisor with GPU passthrough enabled.
2) Install GPU drivers and validate accelerator availability.
3) Install a container runtime and compose-style orchestrator.
4) Deploy the local model runtime, operator UI, automation UI, and research
   gateway as separate services.
5) Configure reverse proxy with TLS certificates from the internal CA.
6) Apply host firewall allowlist rules from the endpoint inventory.

## Update Policy (Ports, Services, IPs)
- Update the endpoint inventory first:
  - `data/firewall/endpoint-ufw-inventory.yml`
- Adjust reverse proxy routes when services move.
- Validate all UI/API endpoints over TLS.
- Record the change in `docs/progress.md`.

## Validation Checklist
- GPU visible in the guest OS.
- Model runtime responds on localhost.
- Operator UI and automation UI respond over TLS.
- Research gateway responds over TLS and blocks non-public inputs.
- Host firewall is enabled with a minimal allowlist.

## Rollback / Revert
- Stop the AI services and reverse proxy.
- Revert the firewall rules to the last known good state.
- Remove model caches if decommissioning.

## Related Policies
- Endpoint firewall + middlebox plan: `docs/endpoint-firewall.md`
