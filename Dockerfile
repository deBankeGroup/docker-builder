FROM docker:stable-git

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base libffi-dev ca-certificates openssl git
ENV RUBY_PACKAGES ruby ruby-bundler ruby-dev
RUN apk add --no-cache $BUILD_PACKAGES    &&\
    apk add --no-cache $RUBY_PACKAGES     &&\
    update-ca-certificates                &&\
    gem install inspec --no-ri --no-rdoc  &&\
    mkdir /project
WORKDIR /project

ARG PROJECT
ARG DATE
ARG DESCRIPTION
ARG URL
ARG COMMIT

LABEL "io.damacus.title"=$PROJECT            \
      "io.damacus.created"=$DATE             \
      "io.damacus.description"=$DESCRIPTION  \
      "io.damacus.url"=$URL                  \
      "io.damacus.revision"=$COMMIT
