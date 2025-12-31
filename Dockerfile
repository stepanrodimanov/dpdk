FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    build-essential \
    meson \
    ninja-build \
    pkg-config \
    libnuma-dev \
    python3 \
    python3-pyelftools \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget -q https://fast.dpdk.org/rel/dpdk-25.11.tar.xz && \
    tar -xf dpdk-25.11.tar.xz && \
    mv dpdk-25.11 dpdk-src && \
    rm dpdk-25.11.tar.xz

COPY /src/main.c /opt/dpdk-src/examples/rxtx_callbacks/main.c

WORKDIR /opt/dpdk-src

RUN meson setup build \
    -Dexamples=rxtx_callbacks \
    && ninja -C build

RUN mkdir -p /opt/scripts
COPY scripts/ /opt/scripts/
RUN chmod +x /opt/scripts/*.sh

RUN mkdir -p /logs

CMD ["/opt/scripts/run.sh"]