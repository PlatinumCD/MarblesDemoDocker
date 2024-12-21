FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Build Args
ARG BUILD_SRC="/src"
ARG BUILD_DEST="/opt"
ARG NUM_THREADS=16

# SST Core Args
ARG SSTCORE_GIT="https://github.com/sstsimulator/sst-core.git"
ARG SSTCORE_BRANCH="v14.0.0_Final"

# SST Elements
ARG SSTELEMENTS_GIT="https://github.com/PlatinumCD/lightweight-sst-elements"
ARG SSTELEMENTS_BRANCH="master"

# Custom SST Element
ARG SST_CUSTOM_ELEMENT_GIT="https://github.com/PlatinumCD/MarblesDemo.git"
ARG SST_CUSTOM_ELEMENT_BRANCH="master"

# Install Dependencies
RUN apt-get update -y && \
    apt-get install -y openmpi-bin openmpi-common \
                       libopenmpi-dev libtool libtool-bin \
                       autoconf python3 python3-pip python3-dev automake \
                       git build-essential vim && \
    rm -rf /var/lib/apt/lists/*

# Install SST Core
RUN git clone -b ${SSTCORE_BRANCH} ${SSTCORE_GIT} ${BUILD_SRC}/sst-core && \
    cd ${BUILD_SRC}/sst-core && ./autogen.sh && \
    mkdir ${BUILD_SRC}/sst-core/build && \
    cd ${BUILD_SRC}/sst-core/build && \
    ../configure \
        MPICC=/bin/mpicc \
        MPICXX=/bin/mpic++ \
        --prefix=${BUILD_DEST}/sst-core && \
    make -j ${NUM_THREADS} install

# Add SST Core binaries to path
ENV PATH="${PATH}:${BUILD_DEST}/sst-core/bin"

# Clone SST Elements
RUN git clone -b ${SSTELEMENTS_BRANCH} ${SSTELEMENTS_GIT} ${BUILD_SRC}/sst-elements

# Clone demo element into SST Elements
RUN cd ${BUILD_SRC}/sst-elements/src/sst/elements && \
    git clone -b ${SST_CUSTOM_ELEMENT_BRANCH} ${SST_CUSTOM_ELEMENT_GIT}

# Build SST Elements
RUN cd ${BUILD_SRC}/sst-elements && ./autogen.sh && \
    mkdir ${BUILD_SRC}/sst-elements/build && \
    cd ${BUILD_SRC}/sst-elements/build && \
    ../configure \
        MPICC=/bin/mpicc \
        MPICXX=/bin/mpic++ \
        --prefix=${BUILD_DEST}/sst-elements && \
    make -j ${NUM_THREADS} install

# Set up environment
ENV BUILD_SRC=${BUILD_SRC}
ENV BUILD_DEST=${BUILD_DEST}
