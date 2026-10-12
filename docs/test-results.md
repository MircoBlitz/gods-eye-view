# Test results

## v0.2.1 update — 2026-10-12

Local validation used Docker Desktop on Apple silicon; GitHub CI supplied native AMD64 validation. No private or paid provider credential was configured. Release `0.2.1-unraid.1` is published for AMD64/ARM64 and promoted unchanged to `latest`.

Source: `v0.2.1`, commit `aa16b7c3b0166a89d8c7a6089e0aff53a22faaee`.
Commit archive SHA-256: `a6020d0aa12a952585edee44a4765ab11f511e3f616927645d7ce04ce48487cb`.

| Check | Result |
|---|---|
| ARM64 image build | Passed; non-root `node`, only port 4173, Docker health check |
| AMD64 image build | Passed under local cross-architecture build |
| Upstream unit suite | 5,615 passed, 1 skipped, 0 failed |
| Upstream production build | Passed |
| ARM64 keyless startup | Healthy through native `docker compose up --wait` |
| HTTP boundary | Root and explicit LAN hostname accepted; foreign Host rejected on root and API |
| Response headers | CSP present and `X-Content-Type-Options: nosniff` |
| Shared Provider Settings | `/api/setup/status` refused with HTTP 403 |
| Cost-bearing request origin | Foreign Origin refused with HTTP 403 before provider use |
| Keyless camera catalog | `/api/cctv/sources` returned HTTP 200 |
| Real WebUI | Helium rendered the startup panel and WebGL globe; no uncaught page errors at capture |
| Real keyless data | OpenSky: 12,384 flights, fresh HTTP 200; 828 satellites, nominal/fresh; 52 USGS earthquakes |
| Missing provider | Active Fires honestly reported unavailable without `FIRMS_MAP_KEY` |
| Lifecycle | Restart and full container recreation each became healthy and repeated HTTP/security checks successfully |
| AMD64 emulated runtime | Failed locally: esbuild's Go runtime aborted with `fatal error: lfstack.push`; not treated as a passing runtime test |
| Native AMD64 CI | Passed health, root-page and Host/Origin/shared-settings boundary checks in run `38275797153` |
| Published candidate | Unauthenticated ARM64 pull with an empty Docker configuration succeeded; package version `0.2.1`, UID 1000, healthy, HTTP/security checks passed |
| Promotion | `latest` and `0.2.1-unraid.1` resolve to identical multi-architecture manifest `sha256:3f19aca4cce953379c8b5ac32ab669fa6d01780d9e2b6adb28844ab3f7feddf0` |

### Test environment qualifications

The first unit-suite attempt in the release image found missing Bash and Git-checkout context, which upstream's tests require. A disposable test container installed Bash and Git and initialized the extracted, unchanged source as a Git working tree. The suite then ran as `node`. No production image dependency or upstream test was changed to make those tests pass. An intermediate root-run attempt was refused by Git's ownership check; the successful run used the correct source owner.

The UI test used actual provider responses, not mocked or synthetic feeds. The full Puppeteer tracking-regression harness was not run: its default browser is Google Chrome for Testing, which is prohibited in this environment. The local Helium check is narrower than that harness.

Test containers and their Compose networks were removed. Local images and working evidence remain available for the pending deployment check.

### Published evidence

- Reviewed source commit: `681673b59a2283c807b9ca60bd4aaa7664d24ddb`.
- [Container CI](https://github.com/MircoBlitz/gods-eye-view/actions/runs/38275797153): success; AMD64/ARM64 builds and native AMD64 runtime.
- [Candidate publication](https://github.com/MircoBlitz/gods-eye-view/actions/runs/38276288742): success; version `0.2.1-unraid.1`.
- [Manifest promotion](https://github.com/MircoBlitz/gods-eye-view/actions/runs/38278965377): success; adds `latest` without rebuilding.

The owner explicitly chose to install the final published update on Unraid through the repository and test it there afterward. No private Unraid shell was used for this release preparation.

## Outstanding

- Unraid-specific installation and public-template-path test of this update.
- Billable/optional-provider checks remain untested and require separately approved credentials.

## Previously published release

`0.1.1-unraid.1` was the previous published `latest` image; it is no longer the current release. Its previous recorded multi-architecture manifest is `sha256:ef235a0c94d56569b30bf8b7fe7d7d2a9d8861a1e50b87445b0e98ac9146feec`. The earlier release passed native GitHub CI and keyless Unraid pull/health checks; those results do not validate v0.2.1.
