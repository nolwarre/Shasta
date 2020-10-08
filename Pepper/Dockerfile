# set the base image
FROM ubuntu:20.04

MAINTAINER Noah Warren <nolwarre@ucsc.edu>

USER root
ENV DEBIAN_FRONTEND=noninteractive

# update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get install -y git cmake make gcc g++ autoconf bzip2 lzma-dev zlib1g-dev \
    libcurl4-openssl-dev libpthread-stubs0-dev libbz2-dev liblzma-dev libhdf5-dev \
    python3-pip python3-virtualenv &&\
    apt-get purge --autoremove -y curl &&\
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CUDA_VERSION 11.1.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-1=11.1.74-1 \
    cuda-compat-11-1 \
    && ln -s cuda-11.1 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# set a working directory
WORKDIR /usr/src

# download software
RUN python3 -m pip install pepper-polish

WORKDIR /usr/src/pepper
