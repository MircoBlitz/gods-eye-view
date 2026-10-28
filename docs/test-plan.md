# Validation plan

Use no paid or private provider credential for the initial test.

## Static

1. Parse `gods-eye-view.xml` and `ca_profile.xml` as XML.
2. Verify the Dockerfile source archive hash and pinned commit.
3. Build for Linux AMD64 and ARM64.
4. Confirm the image runs as a non-root user, exposes only port 4173, and defines a health check.
5. Scan tracked files for accidental credentials.

## Pre-release runtime

Validate locally before publication, then require native AMD64 Container CI. Pull the published candidate without registry credentials and repeat health and HTTP/security checks on the actual artifact. Record architecture and browser limitations honestly. Run the unchanged upstream unit suite and production build in a disposable test environment with the supported Node runtime and Git available; do not add test-only dependencies to the shipped image.

## Unraid keyless runtime

The owner performs this deployment test after publication, exclusively through the repository.

1. Install or update God's Eye View from the published Community Applications repository.
2. Use the published template without optional credentials; do not replace it with a private user-template copy or locally built image.
3. Confirm bridge mode, non-privileged mode, and host mapping `4173:4173`.
4. Start the container and wait for Docker health to report healthy.
5. Open the WebUI through the Unraid Docker page.
6. Confirm the first-run launcher renders and the browser console has no packaging-specific error.
7. Exercise keyless map startup, flights, satellites, earthquakes, and one public camera or radio directory response.
8. Confirm key-required layers report that state rather than pretending to be live.

## Network boundary

1. Confirm the app is reachable from an intended LAN client.
2. Confirm it is not forwarded or exposed to the Internet.
3. Confirm `/api/setup/status` and `POST /api/setup/keys` refuse shared-network clients, including requests with a spoofed local Host. Do not enable gateway trust for this image.
4. Confirm foreign/opaque Origin, cross-site fetch metadata, forwarded headers, and foreign Host are refused on new Google, Mapillary, and Gemini routes before provider credentials would be used.
5. Without keys, verify Mapillary reports unconfigured, Google geocoding reports empty unconfigured results, and Gemini token creation returns 503 for an otherwise admitted same-origin request. Gemini requests without Origin must be refused.
6. Confirm `.env`, local provider configuration, cache/log directories, and generated build output are not exposed as static server content. Check response headers without printing file bodies.
7. Confirm no credential value appears in logs.

## Lifecycle

1. Restart the container and repeat health and WebUI checks.
2. Recreate it from the unchanged template and repeat.
3. Update through the published repository image and verify startup again.
4. Remove the container and confirm no durable application data was promised or retained.

## Optional-provider checks

Exercise a provider only with an owner-approved test credential whose restrictions and quota controls are already configured. Verify the feature, then inspect logs without exposing the value. Billable-provider tests are separate explicit decisions.
