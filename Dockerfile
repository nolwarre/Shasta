# set the base image
FROM ubuntu:20.04

MAINTAINER Noah Warren <nolwarre@ucsc.edu># install dependencies

USER root

RUN apt-get update && \
    apt-get -y install time git make wget autoconf gcc g++ sudo && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

# download software
RUN wget https://github.com/chanzuckerberg/shasta/releases/download/0.5.1/shasta-Ubuntu-20.04-0.5.1.tar && \
    tar -xvf shasta-Ubuntu-20.04-0.5.1.tar && \
    rm shasta-Ubuntu-20.04-0.5.1.tar

WORKDIR /usr/src/shasta-Ubuntu-20.04/bin/

ENV PATH="/usr/src/shasta-Ubuntu-20.04/bin/:${PATH}"
