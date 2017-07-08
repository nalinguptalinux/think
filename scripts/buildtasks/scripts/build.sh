#!/usr/bin/env bash

set -ex

source $(dirname $0)/prepare

echo "Building image..."

# Build and tag
DOCKERFILE="$(dirname $0)/../dockerfiles/prod.Dockerfile"

if [[ ! -z "${BUILD_NUMBER}" ]] ; then
    docker build -t ${IMAGE} \
        --build-arg market=${MARKET} \
        -f ${DOCKERFILE} \
        .
else
    docker build -t ${IMAGE} ./
fi
