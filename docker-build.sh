#!/bin/bash

set -e

PUSH=$1
ARCHES="linux/amd64 linux/arm64"
KASPAD_VERSION="v0.12.14"

docker=docker
id -nG $USER | grep -qw docker || docker="sudo $docker"

echo
echo "===================================================="
echo " Building supertypo/kasboard-processing:latest"
echo "===================================================="
if [ "$PUSH" = "push" ]; then
  $docker buildx create --name=mybuilder --append --node=mybuilder0 --platform=$(echo $ARCHES | sed 's/ /,/g') --bootstrap --use 1>/dev/null 2>&1
  $docker buildx build --push --pull --platform=$(echo $ARCHES | sed 's/ /,/g') \
    --build-arg KASPAD_VERSION="${KASPAD_VERSION}" \
    --tag supertypo/kasboard-processing:latest \
    -f processing/Dockerfile \
    .
else
  $docker build --pull \
    --build-arg KASPAD_VERSION="${KASPAD_VERSION}" \
    --tag supertypo/kasboard-processing:latest \
    -f processing/Dockerfile \
    .
fi

echo
echo "===================================================="
echo " Building supertypo/kasboard-grafana:latest"
echo "===================================================="
if [ "$PUSH" = "push" ]; then
  $docker buildx create --name=mybuilder --append --node=mybuilder0 --platform=$(echo $ARCHES | sed 's/ /,/g') --bootstrap --use 1>/dev/null 2>&1
  $docker buildx build --push --pull --platform=$(echo $ARCHES | sed 's/ /,/g') \
    --tag supertypo/kasboard-grafana:latest \
    -f grafana/Dockerfile \
    .
else
  $docker build --pull \
    --tag supertypo/kasboard-grafana:latest \
    -f grafana/Dockerfile \
    .
fi

