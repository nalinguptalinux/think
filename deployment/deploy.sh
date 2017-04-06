#!/usr/bin/env bash

export PATH=$PATH:/usr/local/bin

if [ -z "$1" ]; then
  echo "Usage:"
  echo "  $0 <site> [environment]"
  exit 1
fi

SITE="$1"
ENVIRONMENT="$2"
ENVIRONMENT=${ENVIRONMENT:=dev}

INVENTORY_FILE="inventory/${SITE}/${ENV}/inventory"

if [ ! -e "${INVENTORY_FILE}" ]; then
  echo "Unable to locate inventory file ${INVENTORY_FILE}"
  exit 2
fi

# Set the versions /  build numbers

if [ "${VERSION_HP}" != "latest" ]; then
	VERSION_HP="build-${VERSION_HP}"
fi
if [ "${VERSION_SRPPDP}" != "latest" ]; then
	VERSION_SRPPDP="build-${VERSION_SRPPDP}"
fi
if [ "${BUILD_NGINX}" != "latest" ]; then
	BUILD_NGINX="build-${BUILD_NGINX}"
fi

# Let ansible run the deployment

ansible-playbook -i ${INVENTORY_FILE} frontend.yml -vvvv \
  --extra-vars="build=${BUILD_NUMBER} nginx_ecr_repo=nginx:${BUILD_NGINX} hp_ecr_repo=hp:${VERSION_HP} srp_pdp_ecr_repo=srp-pdp:${VERSION_SRPPDP}"
