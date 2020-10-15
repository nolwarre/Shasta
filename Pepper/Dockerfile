FROM nvidia/cuda:latest

MAINTAINER Noah Warren <nolwarre@ucsc.edu>

# update and install dependencies
RUN apt-get update && \
    apt-get -y install git cmake make gcc g++ autoconf bzip2 lzma-dev zlib1g-dev && \
    apt-get -y install libcurl4-openssl-dev libpthread-stubs0-dev libbz2-dev liblzma-dev libhdf5-dev && \
    apt-get -y install python3-pip python3-virtualenv virtualenv && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set a working directory
WORKDIR /usr/src

# download software
RUN python3 -m pip install pepper-polish

WORKDIR /usr/src/pepper
