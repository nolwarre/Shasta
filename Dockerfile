
# set the base image
FROM ubuntu:18.04

MAINTAINER Noah Warren <nolwarre@ucsc.edu># install dependencies

RUN apt-get update && \
    apt-get -y install time git make wget autoconf gcc g++ sudo && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

# set working directory to download and install
WORKDIR /usr/src

# download software
RUN wget https://github.com/chanzuckerberg/shasta/releases/download/0.5.1//shasta-Linux-0.5.1

RUN chmod ugo+x shasta-Linux-0.5.1

RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 -m ubuntu
USER ubuntu

CMD ["/bin/bash"]
