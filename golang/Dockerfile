ARG     VERSION=1.12.6
FROM    golang:1.12.6-alpine3.10

ENV     TERRAFORM_VERSION="0.12.2"
ENV     TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
ENV     TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP}"
ENV     ANSIBLE_HOST_KEY_CHECKING="False"

RUN     apk add --no-cache wget unzip py-pip ansible \
        && wget -nv ${TERRAFORM_URL} \
        && unzip ${TERRAFORM_ZIP} -d /usr/bin/ \
        && chmod +x /usr/bin/terraform \
        && pip install awscli \
        && apk -v --purge del py-pip \
        && rm ${TERRAFORM_ZIP}