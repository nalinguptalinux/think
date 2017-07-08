#!/usr/bin/env bash

# This script needs to be executed from within the project to be built

set -ex

source $(dirname $0)/prepare

echo "Linting image..."

docker run --rm --name ${TEST_CONTAINER_PREFIX}_lint ${IMAGE} yarn eslint

