# Test results

## Current status

**Image built and template staged; container runtime validation pending.**

No God's Eye View container or provider credential has yet been created on Unraid by this project.

## Completed

- upstream repository and `v0.1.1` release inspected
- upstream archive SHA-256 independently downloaded and verified
- `gods-eye-view.xml` and `ca_profile.xml` parsed successfully with `xmllint`
- XML contract check passed for 14 unique settings, bridge networking, non-privileged mode, image name, and port mapping
- GitHub workflow contract check passed for AMD64/ARM64 and GHCR image naming
- tracked-file secret-pattern scan passed
- Git whitespace validation passed
- AMD64 image built successfully on dienerwurm with Docker 29.5.3
- local image `ghcr.io/mircoblitz/gods-eye-view:latest` created as non-root user `node`, image ID `sha256:cf7da528af567621e7d06a2a3e5743be1d5ab789b62ad22d33c6b76429788a07`, size 488,459,156 bytes
- template staged at `/boot/config/plugins/dockerMan/templates-user/my-gods-eye-view.xml` with mode `0644`

## Outstanding

- Docker health check
- template-based container installation
- keyless WebUI and layer checks
- restart and recreation
- multi-architecture CI build
- GHCR publication
