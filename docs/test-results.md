# Test results

## Current status

**Keyless container starts and reports healthy; interactive globe validation remains pending.**

No provider credential has been used. A temporary pre-publication container is running on host port `14173`; the final Unraid template remains uninstalled.

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
- temporary keyless container started as unprivileged user `node` and reached Docker health status `healthy`
- upstream Vite 6.4.3 reported ready in 510 ms with no startup error in container logs
- browser reached the app, verified title `God's Eye View`, one canvas, the branded startup screen, and no visible DOM error surface
- Camofox remained on `Initializing photorealistic world`; this does not prove the interactive globe or live layers work in a WebGL-capable user browser

## Outstanding

- template-based container installation on host port 4173
- interactive globe initialization in the user's browser
- keyless WebUI and layer checks
- restart and recreation
- multi-architecture CI build
- GHCR publication
