FROM docker:stable-git

ENV BUILD_PACKAGES bash curl curl-dev ruby-dev build-base libffi-dev ca-certificates openssl git
ENV RUBY_PACKAGES ruby ruby-bundler ruby-dev
COPY install_ghr.sh /install_ghr.sh
RUN apk add --no-cache $BUILD_PACKAGES    &&\
    apk add --no-cache $RUBY_PACKAGES     &&\
    update-ca-certificates                &&\
    gem install inspec --no-ri --no-rdoc

RUN chmod +x /install_ghr.sh        &&\
    ./install_ghr.sh                &&\
    mkdir /project
WORKDIR /project

ARG PROJECT=unknown
ARG DATE=unknown
ARG DESCRIPTION=unknown
ARG URL=unknown
ARG COMMIT=unknown

LABEL "io.damacus.title"=$PROJECT            \
      "io.damacus.created"=$DATE             \
      "io.damacus.description"=$DESCRIPTION  \
      "io.damacus.url"=$URL                  \
      "io.damacus.revision"=$COMMIT
