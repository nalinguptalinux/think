#!/usr/bin/env bash
set -ex

source $(dirname $0)/prepare

echo "Pushing image..."

if [ "${BUILD_NUMBER}" != "snapshot" ]; then
    for repository_uri in ${ECR_REPO_URIS};
    do
        registry=$(echo $repository_uri | awk -F '.' '{print $1}')
        region=$(echo $repository_uri | awk -F '.' '{print $4}')
        eval $(aws ecr get-login --registry-ids $registry --region $region)
        docker tag ${IMAGE} ${repository_uri}/${ECR_REPO_NAME}:latest
        docker tag ${IMAGE} ${repository_uri}/${ECR_REPO_NAME}:${BUILD_NUMBER}
        docker push ${repository_uri}/${ECR_REPO_NAME}:latest
        docker push ${repository_uri}/${ECR_REPO_NAME}:${BUILD_NUMBER}
    done
fi
