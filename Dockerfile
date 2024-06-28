ARG org=manasrc
ARG project=action-release
ARG target=x86_64-unknown-linux-musl

#
# Builder
#

FROM rust:1.79.0-alpine3.20 AS builder

ARG org
ARG project
ARG target

RUN apk add --no-cache musl-dev
RUN rustup target add ${target}

COPY . .

RUN cargo build --target ${target} --release

#
# Runner
#

FROM alpine:3.20

ARG org
ARG project
ARG target

COPY --from=builder ./target/${target}/release/${project} .

ENTRYPOINT [ "action-release" ]
