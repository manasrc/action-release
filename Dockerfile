FROM rust:1.79.0-alpine3.20

RUN apk add --no-cache musl-dev
RUN rustup target add x86_64-unknown-linux-musl

COPY . .

RUN cargo build --target ${target} --release

ENTRYPOINT [ "./target/x86_64-unknown-linux-musl/release/action-release" ]
