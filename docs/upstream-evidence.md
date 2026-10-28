# Upstream evidence

Source assessed against God's Eye View `v0.3.0`, commit `72eb3fdc739991a1286b7f1251de908e9744bb2a`. Source inspection is not a runtime test; see [test results](test-results.md) for actual validation.

| Packaging decision | Upstream evidence |
|---|---|
| Moving Node 24 Alpine base | `package.json` requires `>=24.14.0 <25` or Node 26; the base tracks Node 24 patch updates |
| Run `npm run dev` | The script runs Vite, whose standalone server owns the client and required provider proxies |
| Do not use the upstream Docker launcher | `scripts/docker-start.mjs` adds the Docker gateway to trusted Provider Settings peers for upstream's loopback-bound personal-install setup; shared-LAN packaging must not grant that trust |
| Listen on port 4173 with `HOST=0.0.0.0` | The standalone configuration reads these settings; `build/allowedHosts.js` still enforces explicit host admission |
| Keyless first start | README documents Esri/OSM, live feeds, and Panoramax/KartaView Street Level without a provider key |
| Environment-based credentials | Standalone Vite loads provider environment variables; Provider Settings keeps local socket/Host/Origin admission checks |
| Explicit LAN hostnames | `build/allowedHosts.js` rejects wildcard/suffix entries; `GEV_ALLOWED_HOSTS` permits named hosts |
| Public client credentials | `build/vite.js` injects Google Maps, Cesium ion, and Mapillary client values into the browser; `SECURITY.md` documents restrictions |
| Separate Google server key | `server/providers/places/google-key.js` prefers `GOOGLE_MAPS_SERVER_API_KEY` for server requests and otherwise falls back to the browser key |
| Optional Gemini and Ontario keys | Their provider modules keep permanent keys server-side; neither is required for startup |
| Request boundaries | `src/localRequestGate.mjs` and provider admission reject foreign Origin, cross-site metadata, and forwarded requests on cost-bearing routes |
| No persistent application volume | Shared packaging has no application database; GhostMaps downloads and TomTom budget state are disposable container-layer files |
| Preserve the existing TomTom template default | The template keeps its existing 40,000-tile budget; v0.3.0 upstream defaults to 6,000. This is an intentional retained configuration, not a billing cap |
| Reviewed release archive | The annotated `v0.3.0` tag resolves to the recorded commit; commit-archive SHA-256 is `64891e03f3469ed5577daa00f982277bd9a07377c9053ae6e85a1f7d1e1ab0c5` |
| Retain the Unraid image build | v0.3.0 has an official Dockerfile and Compose setup, but the inspected release files and CI identify no usable published application-image reference; Compose builds from source |

Primary source: [v0.3.0 tree](https://github.com/bilawalsidhu/gods-eye-view/tree/v0.3.0). License and dataset qualifications remain in [third-party notices](../THIRD_PARTY_NOTICES.md) and upstream `DATA_SOURCES.md`.

The server is an exploratory development/preview service, not a hardened authenticated multi-user deployment.
