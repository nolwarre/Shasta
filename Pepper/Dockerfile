ARG BASE_IMAGE=nvidia/cuda:11.1-base
ARG PYTHON_VERSION=3.8

FROM ${BASE_IMAGE} as dev-base

MAINTAINER Noah Warren <nolwarre@ucsc.edu>

USER root
ENV DEBIAN_FRONTEND=noninteractive

# update and install dependencies
RUN apt-get update && \
    apt-get -y install curl git ca-certificates ccache cmake make gcc g++ autoconf bzip2 lzma-dev zlib1g-dev \
    libcurl4-openssl-dev libpthread-stubs0-dev libbz2-dev liblzma-dev libhdf5-dev \
    libjpeg-dev libpng-dev \
    python3-pip python3-virtualenv virtualenv protobuf-compiler libprotoc-dev && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN /usr/sbin/update-ccache-symlinks
RUN mkdir /opt/ccache && ccache --set-config=cache_dir=/opt/ccache
ENV PATH /opt/conda/bin:$PATH

FROM dev-base as conda
RUN curl -fsSL -v -o ~/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda install -y python=${PYTHON_VERSION} conda-build pyyaml numpy ipython && \
    /opt/conda/bin/conda clean -ya && \
    python3 -m pip install pepper-polish && \
    rm -rf ~/miniconda
