#!/bin/sh
RELEASE='v0.5.4'
curl -L -O https://github.com/tcnksm/ghr/releases/download/${RELEASE}/ghr_${RELEASE}_linux_amd64.zip
unzip ghr_${RELEASE}_linux_amd64.zip
rm ghr_${RELEASE}_linux_amd64.zip
mv ghr /usr/local/bin
hash ghr
