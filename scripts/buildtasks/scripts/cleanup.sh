#!/usr/bin/env bash

set -ex

source $(dirname $0)/prepare

echo "Cleaning up..."

docker rmi ${IMAGE}

for repository_uri in ${ECR_REPO_URIS};
do
  docker rmi ${repository_uri}/${ECR_REPO_NAME}:${BUILD_NUMBER}
  docker rmi ${repository_uri}/${ECR_REPO_NAME}:latest
done