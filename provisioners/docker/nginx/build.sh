#!/bin/env bash

cd provisioners/docker/nginx
docker build -t nginx .

for repository_uri in ${ECR_REPO_URIS};
do
  registry=$(echo $repository_uri | awk -F '.' '{print $1}')
  region=$(echo $repository_uri | awk -F '.' '{print $4}')
  eval $(aws ecr get-login --registry-ids $registry --region $region)
  docker tag nginx:latest ${repository_uri}/nginx:latest
  docker tag nginx:latest ${repository_uri}/nginx:${BUILD_NUMBER}
  docker push ${repository_uri}/nginx:latest
  docker rmi ${repository_uri}/nginx:latest
  docker push ${repository_uri}/nginx:${BUILD_NUMBER}
  docker rmi ${repository_uri}/nginx:${BUILD_NUMBER}
done

# Add build number to the list file
/bin/sed -i "1s;builds=;builds=${BUILD_NUMBER},;" ${WORKSPACE}/../${JOB_BASE_NAME}-build-numbers.txt
/bin/echo "last=${env.BUILD_NUMBER}" > ${WORKSPACE}../${JOB_BASE_NAME}-last-build.txt
