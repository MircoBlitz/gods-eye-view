# Operations

## Start and health

The container starts the upstream Vite server on port `4173`. Docker health checks the root page every 30 seconds.

A healthy root page proves that the web server answers; it does not prove every external provider is available. Verify layers individually in the UI.

## Logs

Use the Unraid Docker log view. Provider failures should be diagnosed without copying credentials into commands or support reports.

## Updates

Before changing the pinned upstream revision:

1. Read upstream release and security notes.
2. Record the running image ID.
3. Update both `GEV_COMMIT` and `GEV_ARCHIVE_SHA256` in `Dockerfile`.
4. Build and execute the validation plan.
5. Publish only the validated multi-architecture image.

There is no persistent application database to migrate or back up. Provider credentials remain in the Unraid template configuration.

## Uninstall

Removing the container removes its transient caches. Removing the image reclaims image storage. The template file and Unraid's saved container configuration are separate and can be removed through Unraid when no longer required.
