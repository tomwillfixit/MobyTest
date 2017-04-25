FROM golang:1.7.5-alpine3.5

#Set ENV vars
ENV CGO_ENABLED=0 \
    CONFIG_FILE

#Install linuxKit 'moby' tool
RUN set -ex \
    && apk update \
    && apk add --no-cache \
           bash \
           git \
           qemu-system-x86_64 \
           gcc \
           docker \
           openrc \
    && go get -u github.com/moby/tool/cmd/moby

#Add entrypoint
COPY entrypoint.sh /tmp

WORKDIR /images
VOLUME /images
VOLUME /configs

ENTRYPOINT /tmp/entrypoint.sh
