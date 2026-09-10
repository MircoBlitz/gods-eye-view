# Upstream evidence

Validated against God's Eye View `v0.1.1`, commit `65bc522f49dc1166eca533996be8e789ad36cfe5`.

| Packaging decision | Upstream evidence |
|---|---|
| Node 24.14.0 | `package.json` requires `>=24.14.0 <25` or Node 26 |
| Run `npm run dev` | `package.json` maps it to Vite; upstream states the Vite server owns required same-origin provider proxies |
| Listen on port 4173 | `.env.example` and README use port 4173 |
| Set `HOST=0.0.0.0` | upstream defaults to localhost and requires explicit all-interface binding for LAN access |
| Keyless first start | upstream README documents Esri/OSM and multiple live keyless sources |
| Configure credentials as environment variables | `.env.example` documents the supported variables; Provider Settings is disabled during network sharing |
| Default OpenSky mode `anon` | `.env.example` documents `anon` as the credential-free mode |
| Google and Cesium values masked but client-visible | upstream `SECURITY.md` states both are injected into the browser and must be provider-restricted |
| Trusted-LAN warning | upstream `SECURITY.md` states that any reachable client can spend configured provider quota |
| No persistent volume | upstream has no durable application database; `.gev-cache` is a disposable proxy cache |
| Source archive pin | Git tag `v0.1.1` resolves to the recorded commit; downloaded archive SHA-256 is `e0b7cb41aaad3f493043db18f7257fad539b6cda7441bb075d9a36307fede409` |

The upstream project calls this an evolving exploratory client and explicitly says the Vite server is not a hardened production service. This image does not claim otherwise.
