#!/bin/sh
export PROJECT='docker-builder'
export DESCRIPTION='Docker container with Docker, Inspec and Ruby'
export MAINTAINER='damacus'
export FILE='Dockerfile'

if ! [[ -e .docker/external_functions.sh ]];then
  wget -O '.docker/external_functions.sh' 'https://raw.githubusercontent.com/damacus/docker-build-scripts/master/functions.sh'
fi

source '.docker/external_functions.sh'
