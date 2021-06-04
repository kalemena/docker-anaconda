#!/bin/bash

BASE_IMAGE=${BASE_IMAGE:-python:3.8.8}
IMAGE=${IMAGE:-kalemena/anaconda}
VERSION=${VERSION:-latest}

# PREPARE
docker -v
docker pull ${BASE_IMAGE} || true
docker pull ${IMAGE}:${VERSION} || true

# BUILD
docker build --pull --cache-from ${IMAGE}:${VERSION} \
    -t ${IMAGE}:${VERSION} \
    -f Dockerfile \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg VERSION=${VERSION} .

# CHECK
docker ps -a
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
docker images
