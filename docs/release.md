# Release procedure

Publication is separate from ordinary CI. Source pushes, candidate publication and manifest promotion require their applicable explicit approvals.

## Validate and publish the source

1. Read the upstream release/security notes and confirm whether a usable official image can replace this packaging.
2. Update the reviewed source and archive hash under the existing release-build contract, and update the template metadata/configuration.
3. Complete the applicable local checks in `test-plan.md` and record actual results and limitations in `test-results.md`.
4. Review the exact staged diff, commit a coherent update, and publish the approved source to `MircoBlitz/gods-eye-view` on `main`.
5. Require `Container CI` to pass, including native AMD64 startup/security checks and AMD64/ARM64 builds.

## Publish and verify a candidate

Run the manual **Publish container** workflow on the reviewed source with an immutable release identifier such as `0.2.1-unraid.1`.

It publishes one AMD64/ARM64 candidate manifest under the entered version and the source commit SHA tag. It does not change `latest`.

Verify an unauthenticated pull and local keyless runtime of the actual published candidate. Record its manifest digest and package version. A source build or successful publishing job alone does not prove a public image is pullable or starts.

## Promote the tested image

After the applicable checks pass and promotion is approved, run **Promote tested image** with that exact version. It adds `latest` to the tested manifest without rebuilding it. Verify that both tags resolve to the same digest.

## Publish the Community Applications template

Publish the corresponding approved template to `MircoBlitz/unraid-community-apps` on `main`, and update the release documentation here. Do not advertise the new application version while `latest` still serves the old one.

Verify these public paths:

- `https://raw.githubusercontent.com/MircoBlitz/unraid-community-apps/main/templates/gods-eye-view.xml`
- `https://raw.githubusercontent.com/MircoBlitz/gods-eye-view/main/assets/gods-eye-view.png`
- `https://github.com/MircoBlitz/gods-eye-view/pkgs/container/gods-eye-view`

The owner installs the final release on Unraid through the published repository and then performs health, WebUI, keyless-layer, restart and recreation checks there. Do not stage a private template or deploy a locally built image to that server as a substitute. Record this deployment test separately; prior release evidence does not validate the new release.
