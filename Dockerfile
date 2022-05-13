# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y pkg-config

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev

## Add source code to the build stage.
ADD . /hcxtools
WORKDIR /hcxtools

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /hcxtools/hcxwltool /
