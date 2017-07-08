#!/usr/bin/env bash

GIT_COMMIT=$(git rev-parse HEAD)

cat > $(dirname $0)/../../version <<EOF
{
  "build":"${BUILD_NUMBER}",
  "commit": "${GIT_COMMIT}"
}
EOF
