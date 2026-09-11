# God's Eye View for Unraid

Docker image and Unraid Community Applications template for [God's Eye View](https://github.com/bilawalsidhu/gods-eye-view).

The image packages the upstream `v0.1.1` application at commit `65bc522f49dc1166eca533996be8e789ad36cfe5`. The source archive is checksum-verified during the build. CI validates AMD64 and ARM64 without publishing; a separate manual workflow performs an approved release.

## Status

Candidate `0.1.1-unraid.1` is published for AMD64 and ARM64. Its unauthenticated pull and keyless Docker health test passed on Unraid, and the tested manifest was promoted unchanged to `latest`. Community Applications submission remains pending; see [test results](docs/test-results.md).

## What works without keys

The app starts without an account or API key. Its keyless paths include Esri satellite imagery with OSM fallback, flights, military traffic, satellites, earthquakes, public cameras, radio, launches, bikeshare, and simulated road traffic. Optional providers add photorealistic 3D, place search, voice, ships, fires, and live traffic-flow speeds.

## Install on Unraid

Use this template URL:

```text
https://raw.githubusercontent.com/MircoBlitz/gods-eye-view/main/gods-eye-view.xml
```

For a manual test, copy `gods-eye-view.xml` to:

```text
/boot/config/plugins/dockerMan/templates-user/my-gods-eye-view.xml
```

Then open:

```text
Docker → Add Container → Template → User Templates → Gods-Eye-View
```

The default web interface is:

```text
http://UNRAID-IP:4173/
```

No provider credential is required for the first start. Add optional credentials through the Unraid template, not through the in-app Provider Settings panel.

## Security boundary

God's Eye View is an exploratory application, not a hardened multi-user service. The container listens on the Unraid host so browsers on the LAN can use it, but the app has no login. Anyone who can reach it can call its provider-backed endpoints and consume configured quotas.

Use it only on a trusted LAN/VPN or behind a separately reviewed authenticated reverse proxy. Set provider-side restrictions, quotas, and spending limits before adding billable credentials. The template enables application-level request limits for OpenAI and Google, but these are not billing caps.

`GOOGLE_MAPS_API_KEY` and `CESIUM_ION_TOKEN` are deliberately delivered to the browser by the upstream app. Treat them as public client credentials and restrict them at their providers. Other configured keys remain server-side.

See [security](docs/security.md) and upstream's [SECURITY.md](https://github.com/bilawalsidhu/gods-eye-view/blob/v0.1.1/SECURITY.md).

## Image behavior

The container runs the upstream Vite server because it owns the application's same-origin data proxies. It is honestly a development/preview server; upstream does not currently provide a hardened production server.

- container port: `4173/tcp`
- process user: unprivileged `node` user
- health check: HTTP request to `127.0.0.1:4173`
- persistent application data: none
- provider credentials: Unraid environment variables
- transient proxy caches: container writable layer; removed with the container

## Updates

The Dockerfile deliberately pins the upstream commit and archive SHA-256. An update requires changing both values, rebuilding, and repeating the validation plan. The Unraid template follows the moving `latest` image tag after publication.

## Documentation

- [Upstream evidence](docs/upstream-evidence.md)
- [Operations](docs/operations.md)
- [Security](docs/security.md)
- [Validation plan](docs/test-plan.md)
- [Test results](docs/test-results.md)
- [Release procedure](docs/release.md)

## Licenses

This packaging repository is MIT licensed. God's Eye View source is MIT licensed by Bilawal Sidhu. Its bundled datasets and models have separate licenses and usage restrictions; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and upstream's `DATA_SOURCES.md`.
