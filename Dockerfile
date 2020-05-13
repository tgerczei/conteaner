FROM golang:1.14.2-alpine3.11 AS buildenv

ARG VERSION="0.3.0"
ENV TEA_VERSION="${VERSION}"
ARG CGO_ENABLED="0"
ARG GOOS="linux"

WORKDIR $GOPATH/src

RUN	apk add --no-cache git=2.24.3-r0 && \
	git config --global advice.detachedHead false && \
	git clone --single-branch https://gitea.com/gitea/tea -b v${TEA_VERSION} . && \
	go get -v . && \
	go build -v -a -ldflags "-X main.Version=${TEA_VERSION}" -o /tea .

FROM scratch
LABEL maintainer="Tamás Gérczei <tamas@gerczei.eu>"
COPY --from=buildenv /tea /
ENV HOME="/app"
ENTRYPOINT ["/tea"]
