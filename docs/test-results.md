# Test results

## v0.3.0 published release — 2026-10-28

Release `0.3.0-unraid.1` is published for AMD64/ARM64 and promoted to `latest` without rebuilding. The following evidence supersedes the publication gates from local preparation below. No private or paid provider credential was used, and no Unraid deployment test was performed.

- Packaging source commit: `1902e051d6599165341ed31473939771e995dcb1`.
- [Container CI](https://github.com/MircoBlitz/gods-eye-view/actions/runs/40661083855): success; AMD64/ARM64 builds and native AMD64 startup/security checks.
- [Candidate publication](https://github.com/MircoBlitz/gods-eye-view/actions/runs/40770841667): success; version `0.3.0-unraid.1`.
- [Manifest promotion](https://github.com/MircoBlitz/gods-eye-view/actions/runs/40784821439): success; adds `latest` without rebuilding.
- Anonymous registry verification confirmed that `latest`, `0.3.0-unraid.1`, and `sha-1902e05` all resolve to `sha256:462d9ecf2660e1c7ee9d2b197920667a31a772c32a9337b019a087befce9a2c4`.

### Published artifact verification

An anonymous pull using an empty Docker configuration succeeded for that exact index digest. The artifact ran natively on ARM64 as UID/GID 1000 (`node`), with package version `0.3.0`, Node `v24.22.1`, only port `4173`, and `npm run dev`; no gateway trust or provider credentials were supplied.

Docker health, root/security headers, provider admission and missing-credential behavior passed. Provider Settings refused spoofed local Host/Origin requests. Eight provider routes refused tested foreign/opaque Origin, cross-site, foreign-Host and forwarding-header requests. Restart and recreation from the same immutable digest each reached healthy and passed 12 representative root/security/provider checks (24 total), without persistent mounts.

These results do not mean every harness run passed. The initial HTTP harness exited 1 with 89 of 100 assertions passing. Eleven absent-static-path status assumptions failed because those paths returned HTTP 200 HTML, consistent with SPA fallback. File inspection confirmed the targets absent, but response bodies were not inspected. Follow-up checks against the existing `.env.example` and harmless fixtures in actual `/app/dist`, `.gev-cache`, `.gev-logs`, and `.env.candidate-boundary` returned 403 for normal and `/@fs/app/...` URLs (10/10, exit 0). These fixtures were test doubles, not application functionality; no `/rootdist` fixture was used in this published-artifact test.

An initial lifecycle observer accepted an old health event and then failed its immediate state assertion. After inspecting state and event timestamps, the disposable observer was corrected to filter events by action-start time; the subsequent restart/recreation test exited 0. This correction does not turn the earlier failed run into a pass.

The published artifact was runtime-tested only on ARM64. AMD64 manifest/configuration inspection and prior native source CI are not a runtime test of the published AMD64 artifact. No published-artifact browser/WebUI retest, external-feed functional E2E, configured-provider test or Unraid test was performed. The limited final-container log scan found no matching Google/GitHub/OpenAI token patterns in 147 bytes; it was not a comprehensive credential audit. Publication/promotion verification proves image identity, not deployment behavior.

## v0.3.0 local preparation — 2026-10-28

The following results describe local preparation before publication and promotion, not tests of the published artifact. No private or paid provider credential was used, and the running Unraid installation was not changed.

Source: `v0.3.0`, commit `72eb3fdc739991a1286b7f1251de908e9744bb2a`.
Commit archive SHA-256: `64891e03f3469ed5577daa00f982277bd9a07377c9053ae6e85a1f7d1e1ab0c5`.

| Check | Result |
|---|---|
| Source and template checks | Archive hash verified; XML/YAML parsed; both templates have identical configuration fields; new provider credentials optional and empty |
| ARM64 image build | Passed; app 0.3.0, Node v24.22.1, UID 1000, only port 4173, HTTP healthcheck, unchanged `npm run dev` |
| AMD64 image build | Passed; app 0.3.0 and Node v24.22.1 inspected under local emulation |
| Upstream doctor and module boundaries | Passed unchanged |
| Upstream unit suite with allocation gates | 8,808 passed, 2 skipped, 0 failed, including serialized allocation probes |
| Upstream production build | Passed; large-chunk warning only |
| ARM64 keyless startup | Passed through native Compose health readiness |
| Required HTTP checks | 50 passed at each of initial startup, restart, and full recreation |
| Shared Provider Settings | Status and key-write requests refused through the published container port; no automatic gateway trust |
| New provider admission | Google/Mapillary/Gemini refused tested foreign/opaque Origin, cross-site, forwarded, and foreign-Host requests |
| Missing credentials | Mapillary unconfigured; Google empty unconfigured results; admitted Gemini token request HTTP 503 without a key |
| Sensitive-file access | Non-secret sentinel test doubles at `.env`, `pinokio/ENVIRONMENT`, `.gev-cache`, `.gev-logs`, and `dist` were refused with HTTP 403 |
| API error headers | CSP and `X-Content-Type-Options: nosniff` present on tested 403/503 responses; not a full CSP audit |
| Real keyless WebUI | Headless Helium rendered the first-run launcher and Esri globe; 49 earthquakes, 828 satellites, and 6,242 aircraft observed during the test |
| Missing provider UI | Active Fires explicitly unavailable without a FIRMS key |
| Public camera catalog | Initial 30-second timeout; separate later request returned HTTP 200 with 4,000 sources, not proof of individual stream playback |
| AMD64 emulated runtime | Failed with `fatal error: lfstack.push` in esbuild's Go runtime; no native AMD64 verdict follows |
| Credential-pattern check | No obvious private-key/GitHub/OpenAI token patterns in tracked packaging text; heuristic only |
| Targeted security review | No supported defects found in the changed packaging/provider/template/docs/CI path; source-and-evidence review, not a full upstream audit or runtime retest |
| Publication and Unraid update | Not performed during local preparation; subsequent publication/promotion evidence is recorded above |

### Test qualifications

Bash and Git were added only inside a disposable validation container. Its writable layer received an empty Git context so upstream's unchanged file-discovery checks could run; tests ran as `node`. These test-only changes are not present in the shipped Dockerfile.

The HTTP script included an additional invented `/rootdist/validation-sentinel.txt` path. That harmless fixture was served, so each expanded 51-check script exited 1 with 50 required checks passing. This is distinct from the actual root-level `/dist` directory, which was refused. The server is Vite and serves unblocked application assets; these results do not claim arbitrary source-tree paths are private.

The keyless browser check used a separate headless Helium session because remote Camofox could not reach the local loopback port. No Google Chrome download was used. Initial page-error collection was empty, but later console output showed public terrain HTTP 429 throttling and failed terrain tiles. Terrain availability was therefore degraded. Browser interactions were not repeated after recreation; HTTP, health, UID, and startup-process checks were.

All test containers, networks, image tags, sentinel fixtures, and the task-owned browser session were removed. No user container or provider account was modified.

### Remaining verification

The matching [Community Applications template](https://raw.githubusercontent.com/MircoBlitz/unraid-community-apps/main/templates/gods-eye-view.xml) was published at commit `4b335f5e75a3716d37b327d3a0cb97456e602986`. Its 7,919 public bytes matched the tracked file; XML, v0.3.0 metadata, optional new provider fields and Gemini's default of 30 requests/minute were verified.

- Owner's Unraid installation/update through the final published repository, followed by health, WebUI, keyless-layer, restart and recreation checks.
- Billable/optional-provider checks, including Gemini voice and configured Google/Mapillary, remain untested and require separate approved credentials.

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
