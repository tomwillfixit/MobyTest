FROM golang:1.7.5-alpine3.5

#Update to latest packages and install bash
RUN apk update && apk add bash git qemu gcc docker openrc --no-cache

#Install linuxKit 'moby' tool
RUN CGO_ENABLED=0 go get -u github.com/linuxkit/linuxkit/src/cmd/moby

#Add customised JenkinsOS.yml 
ADD JenkinsOS.yml /tmp

ADD entrypoint.sh /tmp

WORKDIR /tmp

ENTRYPOINT ./entrypoint.sh
