#!/bin/env bash

cd provisioners/docker/nginx
docker build -t nginx .

for repository_uri in ${ECR_REPO_URIS};
do
  registry=$(echo $repository_uri | awk -F '.' '{print $1}')
  region=$(echo $repository_uri | awk -F '.' '{print $4}')
  eval $(aws ecr get-login --registry-ids $registry --region $region)
  docker tag nginx:latest ${repository_uri}/nginx:latest
  docker tag nginx:latest ${repository_uri}/nginx:build-${BUILD_NUMBER}
  docker push ${repository_uri}/nginx:latest
  docker push ${repository_uri}/nginx:build-${BUILD_NUMBER}
  docker rmi ${repository_uri}/nginx:build-${BUILD_NUMBER}
done
