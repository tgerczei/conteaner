ARG GOVERSION="1.14.2"

FROM golang:${GOVERSION}-alpine AS buildenv

ARG REPO="https://gitea.com/gitea/tea.git"

ARG VERSION="0.3.0"
ENV TEA_VERSION="${VERSION}"

ARG CGO_ENABLED="0"
ARG GOOS="linux"

WORKDIR $GOPATH/src

RUN	apk add --quiet --no-cache git && \
	git config --global advice.detachedHead false && \
	if [ "${TEA_VERSION}" == "development" ]; \
		then \
			export TEA_VERSION="development-$(git ls-remote -q ${REPO} HEAD | cut -c-7)"; \
		else \
			export BRANCH_MODIFIER="-b v${TEA_VERSION}"; \
	fi && \
	git clone --single-branch ${REPO} ${BRANCH_MODIFIER} . && \
	go get -v . && \
	go build -v -a -ldflags "-X main.Version=${TEA_VERSION}" -o /tea .

FROM scratch
LABEL maintainer="Tamás Gérczei <tamas@gerczei.eu>"
COPY --from=buildenv /tea /
ENV HOME="/app"
ENTRYPOINT ["/tea"]
