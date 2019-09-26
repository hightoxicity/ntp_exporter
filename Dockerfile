FROM golang:1.11.0-alpine3.8 as builder-ntp-exporter
MAINTAINER "Tony Fouchard <djnos14@hotmail.com>"
ENV GOPATH /go
RUN mkdir -p ${GOPATH}/src/github.com/sapcc/ntp_exporter
WORKDIR ${GOPATH}/src/github.com/sapcc/ntp_exporter
ADD ./ ./
RUN apk update && \
    apk add git build-base && rm -rf /var/cache/apk/*
ENV VERSION_CMD "git describe --tags --dirty"
RUN go get -u golang.org/x/net/ipv4
RUN go get -u github.com/beevik/ntp
RUN go build -ldflags "-w -linkmode external -extldflags -static -X main.version=$(${VERSION_CMD})" \
    -o /ntp_exporter

FROM alpine:3.8
COPY --from=builder-ntp-exporter /ntp_exporter /bin/ntp_exporter
ENTRYPOINT ["/bin/ntp_exporter"]
