FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

MAINTAINER Noah Warren <nolwarre@ucsc.edu>

USER root
ENV DEBIAN_FRONTEND=noninteractive

# update and install dependencies
RUN apt-get update && \
    apt-get install -y build-essential git cmake make gcc g++ autoconf ca-certificates \
    bzip2 lzma-dev zlib1g-dev libjpeg-dev libpng-dev\
    libcurl4-openssl-dev libpthread-stubs0-dev libbz2-dev liblzma-dev libhdf5-dev \
    python3-pip python3-virtualenv &&\
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set a working directory
WORKDIR /usr/src

# download software
RUN python3 -m pip install pepper-polish

WORKDIR /usr/src/pepper
