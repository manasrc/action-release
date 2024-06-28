ARG org=manasrc
ARG project=action-release
ARG target=x86_64-unknown-linux-musl
ARG GITHUB_WORKSPACE

#
# Builder
#

FROM rust:1.79.0-alpine3.20 AS builder

ARG org
ARG project
ARG target
ARG GITHUB_WORKSPACE

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
ARG GITHUB_WORKSPACE

COPY --from=builder ${GITHUB_WORKSPACE}/target/${target}/release/${project} .

ENTRYPOINT [ "action-release" ]
