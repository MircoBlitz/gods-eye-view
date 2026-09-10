FROM node:24.14.0-alpine AS app

ARG GEV_COMMIT=65bc522f49dc1166eca533996be8e789ad36cfe5
ARG GEV_ARCHIVE_SHA256=e0b7cb41aaad3f493043db18f7257fad539b6cda7441bb075d9a36307fede409

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
