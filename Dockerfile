ARG org=manasrc
ARG project=action-release
ARG workdir=/usr/src/${org}/${project}
ARG target=x86_64-unknown-linux-musl

#
# Builder
#

FROM rust:1.79.0-alpine3.20 AS builder

ARG org
ARG project
ARG workdir
ARG target

RUN apk add --no-cache musl-dev
RUN rustup target add ${target}

WORKDIR ${workdir}
COPY . .

RUN cargo build --target ${target} --release

#
# Runner
#

FROM alpine:3.20

ARG org
ARG project
ARG workdir
ARG target

WORKDIR ${workdir}/bin
COPY --from=builder /${workdir}/target/${target}/release/${project} .

ENTRYPOINT [ "${project}" ]
