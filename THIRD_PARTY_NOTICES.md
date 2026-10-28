# Third-party notices

## God's Eye View

The container downloads and packages God's Eye View `v0.3.0` from commit `72eb3fdc739991a1286b7f1251de908e9744bb2a`.

Copyright (c) 2026 Bilawal Sidhu. The application source is distributed under the MIT License:

- https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/LICENSE

The unchanged icon in `assets/gods-eye-view.png` was originally rasterized from upstream `public/logo.svg` at `v0.1.1`, commit `65bc522f49dc1166eca533996be8e789ad36cfe5`.

## Data, models, and providers

Upstream's MIT grant does not cover every bundled dataset, model, or runtime data source. In particular, the bundled TeleGeography submarine-cable data is CC BY-NC-SA 3.0 and is not for commercial use. Other bundled data includes ODbL material, and models carry their own licenses.

Review the authoritative upstream notices before deployment or redistribution:

- https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/LICENSE
- https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/THIRD_PARTY_NOTICES.md
- https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/DATA_SOURCES.md
- https://github.com/bilawalsidhu/gods-eye-view/blob/v0.3.0/public/models/README.md

The v0.3.0 bundle also includes Yale Bright Star Catalogue data (public domain), a CC0 CCTV model-spec extract, and a Milky Way background credited to **ESO/S. Brunier** under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Upstream resampled the panorama, removed stars and Jupiter, blurred it, reprojected it to cube faces, adjusted its black level, and converted it to WebP. The detailed source and transformation notice is retained in `src/data/local_data/sky/README.md` inside the application.

Street Level imagery retains each provider's attribution and terms: Mapillary/KartaView CC BY-SA 4.0, per-image Panoramax licenses, and Google terms. Live S2 GhostMaps material is CC BY-NC-SA 4.0; it is not unrestricted commercial-use data. Added camera and bikeshare sources have individual terms, including packs that require explicit operator opt-in. Do not enable them merely because the image includes support.

Live provider data remains subject to each provider's terms, quotas, credential restrictions, and permitted-use rules.
