#!/bin/bash -e

PROJECT="${PWD}"
DESCRIPTION="Docker container with Docker, Inspec and Ruby"
MAINTAINER="damacus"
VCS_URL="https://github.com/${MAINTAINER:?}/${PROJECT:?}"
DATE=$(date +%Y-%m-%dT%T%z)
COMMIT=$(git rev-parse --short HEAD)
FILE="Dockerfile"

source "./.docker/functions.sh";

if [[ -z $CI ]];then
  build
else
  # Load the cache in if we find one
  if [[ -e /caches/app.tar ]];then
    docker load -i /caches/app.tar
    build
  else
    build_without_cache
  fi

  # Save Docker image layer cache
  mkdir -p /caches
  docker save -o /caches/app.tar ${MAINTAINER:?}/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}"
fi
