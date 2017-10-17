#!/bin/sh
NAME="docker-builder"
export PROJECT="${NAME:-$CIRCLE_PROJECT_REPONAME}"
export DESCRIPTION="Docker container with Docker, Inspec and Ruby"
export MAINTAINER="damacus"

if ! [[ -e .docker/functions.sh ]];then
  wget "https://raw.githubusercontent.com/damacus/docker-build-scripts/master/functions.sh" > ".docker/functions.sh"
fi

source ".docker/functions.sh"
