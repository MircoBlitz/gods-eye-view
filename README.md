# God's Eye View for Unraid

Docker image and Unraid Community Applications template for [God's Eye View](https://github.com/bilawalsidhu/gods-eye-view).

This source packages the upstream `v0.3.0` application at commit `72eb3fdc739991a1286b7f1251de908e9744bb2a`. The source archive is checksum-verified during the build. CI is configured to validate AMD64 and ARM64 without publishing; a separate manual workflow performs an approved release.

## Status

Release `0.3.0-unraid.1` is published for AMD64/ARM64 and promoted unchanged to `latest`. Native AMD64 CI passed; an anonymous pull of the published artifact and native ARM64 health, HTTP/provider-security, restart and recreation checks passed. Local preparation also covered unit/build and keyless WebUI checks, but some test harness runs failed; the published artifact was not browser-tested or runtime-tested on AMD64. The matching Community Applications template is published and its public XML verified. The owner's Unraid deployment test remains outstanding. See [test results](docs/test-results.md) for workflow links, the image digest, and test limitations.

Upstream now includes an official Dockerfile and Compose setup. That setup builds from a checkout and is aimed at a loopback-bound personal installation. No usable published application-image reference was identified in the inspected v0.3.0 release files, so this repository continues to build the image used by the Unraid template.

## What works without keys

The app starts without an account or API key. Its keyless paths include Esri satellite imagery with OSM fallback, flights, military traffic, satellites, earthquakes, public camera packs, radio, launches, bikeshare, simulated road traffic, and Panoramax/KartaView Street Level imagery. Optional providers add photorealistic 3D, Google places/geocoding, Mapillary, voice, ships, fires, Ontario 511 cameras, and live traffic-flow speeds. Individual live feeds remain subject to provider availability and terms.

## Install on Unraid

Install or update **Gods-Eye-View** through Community Applications using this repository's published template:

```text
https://raw.githubusercontent.com/MircoBlitz/unraid-community-apps/main/templates/gods-eye-view.xml
```

In Unraid, open **Apps**, select **Gods-Eye-View**, review its configuration and install it. Use that published installation for the deployment test; no private user-template copy or locally built server image is needed.

The default web interface is:

```text
http://UNRAID-IP:4173/
```

No provider credential is required for the first start. Add optional credentials through the Unraid template, not through the in-app Provider Settings panel. Access by IP works without additional configuration. For a LAN hostname, including `.local` names, set `GEV_ALLOWED_HOSTS` to an explicit comma-separated list; wildcard hostnames are rejected.

## Security boundary

God's Eye View is an exploratory application, not a hardened multi-user service. The container listens on the Unraid host so browsers on the LAN can use it, but the app has no login. Anyone who can reach it can call its provider-backed endpoints and consume configured quotas.

Use it only on a trusted LAN/VPN or behind a separately reviewed authenticated reverse proxy. Set provider-side restrictions, quotas, and spending limits before adding billable credentials. The template enables application-level request limits for OpenAI, Gemini, and Google, but these are not billing caps.

`GOOGLE_MAPS_API_KEY`, `CESIUM_ION_TOKEN`, and `MAPILLARY_CLIENT_TOKEN` are deliberately delivered to the browser. Treat them as public client credentials and restrict them at their providers. Use `GOOGLE_MAPS_SERVER_API_KEY` for server-side Places/geocoding rather than relying on a referrer-restricted browser key. Gemini and the other configured private provider keys remain server-side.

See [security](docs/security.md) and upstream's [SECURITY.md](https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/SECURITY.md).

## Image behavior

The container runs the upstream Vite server because it owns the application's same-origin data proxies. It is honestly a development/preview server; upstream does not currently provide a hardened production server.

- container port: `4173/tcp`
- process user: unprivileged `node` user
- health check: HTTP request to `127.0.0.1:4173`
- persistent application data: none
- provider credentials: Unraid environment variables
- transient provider caches and TomTom budget state: container writable layer; removed with the container

The image deliberately starts `npm run dev`, not upstream's Docker launcher. It does not automatically trust the Docker gateway for Provider Settings. Configure keys through the template; experimental local ChatGPT/Codex OAuth voice is not part of this shared-container integration.

## Updates

The existing release-build contract fixes the reviewed upstream commit and archive SHA-256; it does not make the installed image immutable. The Node 24 base image receives ordinary patch updates. An update requires changing both values, rebuilding, and repeating the validation plan. The Unraid template follows the moving `latest` image tag after publication.

## Documentation

- [Upstream evidence](docs/upstream-evidence.md)
- [Operations](docs/operations.md)
- [Security](docs/security.md)
- [Validation plan](docs/test-plan.md)
- [Test results](docs/test-results.md)
- [Release procedure](docs/release.md)

## Licenses

This packaging repository is MIT licensed. God's Eye View source is MIT licensed by Bilawal Sidhu. Its bundled datasets and models have separate licenses and usage restrictions; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and upstream's `DATA_SOURCES.md`.
