ARG     CI_BUILD_VERSION=1.12.7

FROM    golang:1.12.7-alpine3.10
ARG     SEMANTICS_VERSION=v2.0.4
ARG     GOLANGCI_LINT_VERSION=v1.17.1
RUN     apk add --no-cache git make openssh-client bash && \
        GO111MODULE=on go get github.com/stevenmatthewt/semantics@${SEMANTICS_VERSION} github.com/golangci/golangci-lint/cmd/golangci-lint@${GOLANGCI_LINT_VERSION}
