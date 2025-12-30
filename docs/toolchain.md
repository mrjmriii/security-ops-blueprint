# Toolchain pins (epoch)

This folder is meant to be copied into the root of your IaC repo.

## Files

- `.tool-versions` — mise/asdf compatible tool pins
- `docs/toolchain.md` — rationale and notes
- `scripts/bootstrap-controller.sh` — installs repo-local python tooling (venv) and basic OS deps
- `requirements-dev.txt` — Python-based tooling pins (pre-commit, ansible-lint, yamllint)

## Pinned versions

**Runtime / IaC**
- Python 3.14.2
- Terraform 1.14.0
- Ansible (ansible-core) 2.20.1
- Packer 1.14.3

**Platform / build**
- Node.js 24.12.0 (LTS)
- Go 1.25.5
- Rust 1.92.0
- Java 25.0.2 (OpenJDK)

**Lint / validation**
- ShellCheck 0.11.0
- TFLint 0.60.0
- Hadolint 2.11.0
- (Python tooling in requirements-dev.txt)

## Notes

- Docker Engine / Docker Compose are typically installed via OS packages or the vendor install script
  and validated separately; they are not reliably managed via `.tool-versions` across distros.
- K3s is typically installed via the upstream install script; pin the version in your K3s install
  playbooks/manifests rather than `.tool-versions`.

Generated: 2025-12-21
