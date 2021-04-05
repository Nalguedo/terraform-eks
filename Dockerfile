# Docker container based on golang and added awscli | kubectl | terraform
FROM golang:alpine

ENV GLIBC_VER=2.31-r0

ENV TF_DEV=true
ENV TF_RELEASE=true
ENV TERRAFORM_VERSION=0.14.9

# install glibc compatibility for alpine
RUN apk add --no-cache \
        --update \
        git \
        bash \
        openssh \
        wget \
        ca-certificates \
        curl \
        nano \
        binutils \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk 

# kubectl setup - latest stable version
RUN curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl && \
  chmod +x kubectl && \
  mv kubectl /bin/kubectl

RUN rm  -rf /tmp/* /var/cache/apk/*

# Terraform setup
WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

WORKDIR /work

ENV AWS_ACCESS_KEY_ID=somekey
ENV AWS_SECRET_ACCESS_KEY=somekey
ENV AWS_DEFAULT_REGION=eu-west-2
ENV AWS_DEFAULT_OUTPUT=json
#ENTRYPOINT ["terraform"]
#CMD["", ""]