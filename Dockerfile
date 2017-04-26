FROM golang:1.7.5-alpine3.5

#Set ENV vars
ENV CGO_ENABLED=0 \
    OS_CONFIG=

#Install linuxKit 'moby' tool
RUN apk add --no-cache --virtual .builddeps \
           git \
           gcc \
    && apk add --no-cache --virtual .rundeps \
           bash \
           docker \
           openrc \
           qemu-system-x86_64 \
    && go get -u github.com/moby/tool/cmd/moby \
    && apk del .builddeps

#Add entrypoint
COPY entrypoint.sh /tmp

WORKDIR /images
VOLUME /images
VOLUME /configs

ENTRYPOINT /tmp/entrypoint.sh
