# ---- Build Stage ----
FROM elixir:1.14.3-alpine AS builder

ENV MIX_ENV=prod \
    LANG=C.UTF-8

COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile && \
    mix phx.digest && \
    mix release

# ---- Application Stage ----
FROM alpine:3.17
RUN apk add --no-cache --update busybox-extras bash openssl curl

ARG GIT_COMMIT
ARG VERSION

LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

WORKDIR /app

COPY --from=builder _build .

CMD ["/app/prod/rel/${APP_NAME}/bin/${APP_NAME}", "start"]
