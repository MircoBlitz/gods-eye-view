# Security

## Deployment boundary

The container exposes God's Eye View to the local network. The application has no user authentication and its upstream server is intended for local development and preview use.

Keep the port on a trusted LAN/VPN. Internet exposure requires a separately reviewed authenticated TLS reverse proxy and provider-side quota controls.

## Credentials

Configure optional keys through Unraid environment variables. Unraid stores container configuration on its flash device; protect its backups.

- `GOOGLE_MAPS_API_KEY` and `CESIUM_ION_TOKEN` are client-side by upstream design. Restrict them by URL/referrer, API, and quota.
- OpenAI, AISStream, FIRMS, TomTom, OpenSky, and Launch Library credentials remain server-side.
- Anyone who can reach the app can still trigger server-side provider calls.
- Template request limits are process-local guards, reset on restart, and are not billing caps.

Do not publish credentials in this repository, screenshots, logs, or support requests.

## Container

The image runs as the unprivileged Node user, does not require privileged mode, exposes one TCP port, and stores no durable application state. Proxy caches live in the container writable layer and disappear when the container is removed.

Review upstream's security model and provider terms before adding credentials.
