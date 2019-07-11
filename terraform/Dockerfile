ARG     CI_BUILD_VERSION=0.12.3

FROM    alpine:3.10.0 as builder
ARG     KUBECTL_VERSION=v1.15.0
ARG     HELM_VERSION=v3.0.0-alpha.1
RUN     apk add --update --no-cache curl && \
        curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
        tar -xzf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
        curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
        chmod +x kubectl

FROM    hashicorp/terraform:${CI_BUILD_VERSION}
COPY    --from=builder /linux-amd64/helm /kubectl /usr/local/bin/
RUN     apk add --update --no-cache git bash && \
        helm init