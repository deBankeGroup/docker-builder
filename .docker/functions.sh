#!/bin/sh
set +o pipefail

PROJECT="$(basename "$(pwd)")"
DESCRIPTION="Docker container with Docker, Inspec and Ruby"
MAINTAINER="damacus"
VCS_URL="https://github.com/${MAINTAINER:?}/${PROJECT:?}"
DATE=$(date +%Y-%m-%dT%T%z)
COMMIT=$(git rev-parse --short HEAD)
FILE="Dockerfile"

build() {
  docker build --cache-from="${MAINTAINER}"/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" \
               --build-arg PROJECT="${PROJECT}" \
               --build-arg MAINTAINER="${MAINTAINER}" \
               --build-arg URL="${VCS_URL}" \
               --build-arg DATE="${DATE}" \
               --build-arg COMMIT="${COMMIT}" \
               --build-arg DESCRIPTION="${DESCRIPTION}" \
               --file "${FILE}" \
               --tag "${MAINTAINER}"/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" .
}

push() {
  TAG=${CIRCLE_BUILD_NUM:-beta}

  if [ "${CIRCLE_BRANCH}" = "master" ]; then
    docker login -u "${DOCKER_LOGIN:?}" -p "${DOCKER_PASSWORD:?}"

    printf "\n\n--- Images ---\n\n"
    docker images "${MAINTAINER:?}/${CIRCLE_PROJECT_REPONAME:-$PROJECT:?}"

    printf "\n\n--- Tagging ---\n\n"
    docker tag "${MAINTAINER}/${CIRCLE_PROJECT_REPONAME:-$PROJECT}:latest" "${MAINTAINER}/${CIRCLE_PROJECT_REPONAME:-$PROJECT}:${TAG}"

    printf "\n\n--- Pushing Images to Docker Hub---\n\n"
    docker push "${MAINTAINER}/${CIRCLE_PROJECT_REPONAME}:${TAG}"
  else
    echo "Not on master so not tagging"
    docker images
  fi

}

push_beta() {
  true
}


test() {
  docker run -it "${MAINTAINER}"/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" "$1"
}
