ARG GOVERSION="1.15.6"

FROM golang:${GOVERSION}-alpine AS buildenv

ARG REPO="https://gitea.com/gitea/tea.git"

ARG VERSION="0.6.0"
ENV TEA_VERSION="${VERSION}"

ARG CGO_ENABLED="0"
ARG GOOS="linux"

ARG BUILD_DATE

WORKDIR $GOPATH/src

RUN	apk add --quiet --no-cache git && \
	git config --global advice.detachedHead false && \
	git clone --single-branch ${REPO} -b v${TEA_VERSION} . && \
	go get -v . && \
	go build -v -a -ldflags "-X main.Version=${TEA_VERSION}" -o /tea .

FROM scratch
ARG BUILD_DATE
ARG VERSION="0.6.0"
LABEL org.opencontainers.image.title="Gitea - Git with a cup of tea"
LABEL org.opencontainers.image.description="A command line tool to interact with Gitea servers"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.url="https://gitea.com/gitea/tea"
LABEL org.opencontainers.image.authors="Tamás Gérczei <tamas@gerczei.eu>"
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.source="https://github.com/tgerczei/conteaner"
LABEL org.opencontainers.image.vendor="Gérczei Tamás E.V."
COPY --from=buildenv /tea /
ENV HOME="/app"
ENTRYPOINT ["/tea"]
