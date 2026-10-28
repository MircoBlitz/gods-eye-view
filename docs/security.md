# Security

## Deployment boundary

The container exposes God's Eye View to the local network. The application has no user authentication and its upstream server is intended for local development and preview use.

Keep the port on a trusted LAN/VPN. Internet exposure requires a separately reviewed authenticated TLS reverse proxy and provider-side quota controls.

## Credentials

Configure optional keys through Unraid environment variables. Unraid stores container configuration on its flash device; protect its backups.

- `GOOGLE_MAPS_API_KEY`, `CESIUM_ION_TOKEN`, and `MAPILLARY_CLIENT_TOKEN` are client-visible by upstream design. Apply their provider-supported restrictions and quotas; masking the template field does not keep the value out of browsers.
- Use a separate `GOOGLE_MAPS_SERVER_API_KEY` for Places, geocoding, and Street View Static with server-IP/API restrictions. Without it, upstream falls back to the browser key; referrer-restricted keys cannot serve those server-side Google requests.
- OpenAI, Gemini, Ontario 511, AISStream, FIRMS, TomTom, OpenSky, and Launch Library credentials remain server-side.
- Anyone who can reach the app can still trigger server-side provider calls.
- OpenAI, Gemini, and Google request limits are process-local guards, reset on restart, and are not billing caps. The TomTom counter is disk-backed only in the disposable container layer and resets on recreation.

Do not publish credentials in this repository, screenshots, logs, or support requests.

## Container

The image runs as the unprivileged Node user, does not require privileged mode, exposes one TCP port, and stores no durable application state. Provider caches, including GhostMaps downloads, live in the writable layer and disappear when the container is removed.

The image uses `npm run dev`, not upstream's Docker launcher that trusts the container gateway. No trusted peers are added automatically. Provider Settings remains local-only: LAN clients are refused even if they spoof a local Host header. This is a network admission boundary, not user authentication. A genuinely container-local loopback tool can still reach local-only endpoints.

Experimental ChatGPT/Codex OAuth voice is not supported by this shared-container integration. Do not mount account credentials or enable voice-content logging as part of normal setup.

Review upstream's security model and provider terms before adding credentials.
