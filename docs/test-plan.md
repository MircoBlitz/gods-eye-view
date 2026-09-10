# Validation plan

Use no paid or private provider credential for the initial test.

## Static

1. Parse `gods-eye-view.xml` and `ca_profile.xml` as XML.
2. Verify the Dockerfile source archive hash and pinned commit.
3. Build for Linux AMD64 and ARM64.
4. Confirm the image runs as a non-root user, exposes only port 4173, and defines a health check.
5. Scan tracked files for accidental credentials.

## Unraid keyless runtime

1. Build or pull the candidate image on Unraid.
2. install the user template without optional credentials.
3. Confirm bridge mode, non-privileged mode, and host mapping `4173:4173`.
4. Start the container and wait for Docker health to report healthy.
5. Open the WebUI through the Unraid Docker page.
6. Confirm the first-run launcher renders and the browser console has no packaging-specific error.
7. Exercise keyless map startup, flights, satellites, earthquakes, and one public camera or radio directory response.
8. Confirm key-required layers report that state rather than pretending to be live.

## Network boundary

1. Confirm the app is reachable from an intended LAN client.
2. Confirm it is not forwarded or exposed to the Internet.
3. Confirm in-app Provider Settings cannot write credentials in shared mode.
4. Confirm no credential value appears in logs.

## Lifecycle

1. Restart the container and repeat health and WebUI checks.
2. Recreate it from the unchanged template and repeat.
3. Update using an equivalent rebuilt image and verify startup again.
4. Remove the container and confirm no durable application data was promised or retained.

## Optional-provider checks

Exercise a provider only with an owner-approved test credential whose restrictions and quota controls are already configured. Verify the feature, then inspect logs without exposing the value. Billable-provider tests are separate explicit decisions.
