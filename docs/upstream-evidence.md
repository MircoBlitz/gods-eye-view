# Upstream evidence

Validated against God's Eye View `v0.2.1`, commit `aa16b7c3b0166a89d8c7a6089e0aff53a22faaee`.

| Packaging decision | Upstream evidence |
|---|---|
| Moving Node 24 Alpine base | `package.json` requires `>=24.14.0 <25` or Node 26; the base tracks Node 24 patch updates |
| Run `npm run dev` | `package.json` maps it to Vite; upstream states the Vite server owns required same-origin provider proxies |
| Listen on port 4173 | `.env.example` and README use port 4173 |
| Set `HOST=0.0.0.0` | upstream defaults to localhost and requires explicit all-interface binding for LAN access |
| Keyless first start | upstream README documents Esri/OSM and multiple live keyless sources |
| Configure credentials as environment variables | `.env.example` documents the supported variables; Provider Settings is disabled during network sharing |
| Default OpenSky mode `anon` | `.env.example` documents `anon` as the credential-free mode |
| Google and Cesium values masked but client-visible | upstream `SECURITY.md` states both are injected into the browser and must be provider-restricted |
| Trusted-LAN warning | upstream `SECURITY.md` states that any reachable client can spend configured provider quota |
| No persistent volume | upstream has no durable application database; `.gev-cache` is a disposable proxy cache |
| Reviewed release archive | Git tag `v0.2.1` resolves to the recorded commit; downloaded commit-archive SHA-256 is `a6020d0aa12a952585edee44a4765ab11f511e3f616927645d7ce04ce48487cb` |
| Explicit LAN hostnames | `build/allowedHosts.js` rejects wildcard/suffix entries; `.env.example` documents `GEV_ALLOWED_HOSTS` |
| Retain our container build | Maintainer decision in [issue #48](https://github.com/bilawalsidhu/gods-eye-view/issues/48) selects still-open [PR #208](https://github.com/bilawalsidhu/gods-eye-view/pull/208); that PR explicitly excludes GHCR publishing. No official usable image was found in the inspected upstream sources on 2026-10-12 |

The upstream project calls this an evolving exploratory client and explicitly says the Vite server is not a hardened production service. This image does not claim otherwise.
