#!/bin/sh
GHR_ELEASE='v0.5.4'
curl -L -O https://github.com/tcnksm/ghr/releases/download/${GHR_ELEASE}/ghr_${GHR_ELEASE}_linux_amd64.zip
unzip ghr_${GHR_ELEASE}_linux_amd64.zip
rm ghr_${GHR_ELEASE}_linux_amd64.zip
mv ghr /usr/local/bin
hash ghr

COMPOSE_VERSION='1.19.0'
apk add --no-cache py-pip
pip install docker-compose==${COMPOSE_VERSION}
