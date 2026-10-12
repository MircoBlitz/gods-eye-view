FROM node:24-alpine AS app

ARG GEV_COMMIT=aa16b7c3b0166a89d8c7a6089e0aff53a22faaee
ARG GEV_ARCHIVE_SHA256=a6020d0aa12a952585edee44a4765ab11f511e3f616927645d7ce04ce48487cb

ENV PUPPETEER_SKIP_DOWNLOAD=true \
    npm_config_audit=false \
    npm_config_fund=false \
    npm_config_update_notifier=false

RUN apk add --no-cache ca-certificates curl
WORKDIR /app
RUN curl --fail --location --silent --show-error \
      "https://github.com/bilawalsidhu/gods-eye-view/archive/${GEV_COMMIT}.tar.gz" \
      --output /tmp/gods-eye-view.tar.gz \
    && echo "${GEV_ARCHIVE_SHA256}  /tmp/gods-eye-view.tar.gz" | sha256sum -c - \
    && tar --extract --gzip --file /tmp/gods-eye-view.tar.gz --strip-components=1 \
    && rm /tmp/gods-eye-view.tar.gz \
    && npm ci \
    && npm cache clean --force \
    && chown -R node:node /app

ENV HOST=0.0.0.0 \
    PORT=4173 \
    OPENSKY_AUTH_MODE=anon

USER node
EXPOSE 4173

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://127.0.0.1:4173/ || exit 1

CMD ["npm", "run", "dev"]
