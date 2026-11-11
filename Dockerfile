FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    cmake \
    clang \
    pkg-config \
    libgmp-dev \
    libmpfr-dev \
    libboost-all-dev \
    libssl-dev \
    coinor-cbc \
    coinor-libcbc-dev \
    z3 \
    python3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="/opt/cargo/bin:${PATH}"

RUN curl https://sh.rustup.rs -sSf | sh -s -- \
    -y --default-toolchain nightly

# Install Zombie's original Rust toolchain
RUN rustup toolchain install nightly-2023-02-01

WORKDIR /workspace

CMD ["/bin/bash"]
