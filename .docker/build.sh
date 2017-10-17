#!/bin/bash -e
source "./.docker/functions.sh";

if [[ -z $CI ]];then
  build
else
  # Load the cache in if we find one
  if [[ -e /caches/app.tar ]];then
    docker load -i /caches/app.tar
  fi
  build

  # Save Docker image layer cache
  mkdir -p /caches
  docker save -o /caches/app.tar ${MAINTAINER:?}/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}"
fi
