#!/bin/sh
build() {
  docker build --cache-from=${MAINTAINER}/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" \
               --build-arg PROJECT="${PROJECT}" \
               --build-arg MAINTAINER="${MAINTAINER}" \
               --build-arg URL="${VCS_URL}" \
               --build-arg DATE="${DATE}" \
               --build-arg COMMIT="${COMMIT}" \
               --build-arg DESCRIPTION="${DESCRIPTION}" \
               --file ${FILE} \
               --tag ${MAINTAINER}/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" .
}

build_without_cache() {
  docker build --build-arg PROJECT="${PROJECT}" \
               --build-arg MAINTAINER="${MAINTAINER}" \
               --build-arg URL="${VCS_URL}" \
               --build-arg DATE="${DATE}" \
               --build-arg COMMIT="${COMMIT}" \
               --build-arg DESCRIPTION="${DESCRIPTION}" \
               --file ${FILE} \
               --tag ${MAINTAINER}/"${CIRCLE_PROJECT_REPONAME:-$PROJECT}" .
}
