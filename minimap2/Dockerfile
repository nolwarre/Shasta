# set the base image
FROM ubuntu:20.04

MAINTAINER Noah Warren <nolwarre@ucsc.edu>

USER root

RUN apt-get update && \
    apt-get -y install \
    time git make autoconf gcc g++ sudo wget build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set a working directory
WORKDIR /usr/src

# download software
RUN git clone https://github.com/lh3/minimap2 && \
    cd minimap2 && \
    make

# set a working directory
WORKDIR /usr/src

# download software
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar xjf samtools-1.10.tar.bz2 && \
    # clean up compressed files, don't need them and reduces container size
    rm samtools-1.10.tar.bz2 && \
    # set up and installation commands for software
    cd samtools-1.10 && \
    ./configure --prefix $(pwd) && \
    make

ENV PATH="/usr/src/minimap2:${PATH}"
ENV PATH="/usr/src/samtools-1.10:${PATH}"
