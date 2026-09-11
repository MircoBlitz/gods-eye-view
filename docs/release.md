# Release procedure

Publication is deliberately separate from ordinary CI.

## Before publication

1. Complete every applicable item in `test-plan.md` and record evidence in `test-results.md`.
2. Confirm the working tree is clean and the intended commit is on `main`.
3. Create the public GitHub repository `MircoBlitz/gods-eye-view` only after explicit publication approval.
4. Push `main` and require the `Container CI` workflow to pass.
5. Review the resulting source repository, template URLs, image labels, and third-party notices.

## Publish the image

From GitHub Actions, run the manual `Publish container` workflow and enter an immutable version such as `0.1.1-unraid.1`.

The workflow publishes one AMD64/ARM64 manifest under three tags:

- `latest`
- the entered immutable version
- the source commit SHA tag

After the first push, set the GHCR package visibility to public. Verify an unauthenticated pull before announcing the template.

## Publish the template

Verify that these public URLs answer successfully:

- `https://raw.githubusercontent.com/MircoBlitz/gods-eye-view/main/gods-eye-view.xml`
- `https://raw.githubusercontent.com/MircoBlitz/gods-eye-view/main/assets/gods-eye-view.png`
- `https://github.com/MircoBlitz/gods-eye-view/pkgs/container/gods-eye-view`

Install once from the public template URL on Unraid and repeat the health, WebUI, keyless-layer, restart, and recreation checks. Community Applications submission is a separate publication step after that public-path test passes.
