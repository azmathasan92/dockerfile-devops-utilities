FROM alpine:3.14.0

USER root

ARG HELM_VERSION="2.16.11"
ARG TERRAFORM_VERSION="0.15.0"
ARG KUBECTL_VERSION="1.18.0"
ARG VAULT_VERSION="1.7.1"
ARG HELMSWITCH_VERSION="0.0.5"

# Add useful packages
RUN apk add --update coreutils --no-cache --virtual .build-deps \
  bash \
  jq \
  git \
  openssh \
  curl \
  libc6-compat \
  && rm -rf /var/cache/apk/*

# Install kubectl
RUN curl -sL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
  chmod +x /usr/local/bin/kubectl && \
  kubectl version --client=true

# Install vault
RUN curl -sL -o vault_linux_amd64.zip "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" && \
  unzip vault_linux_amd64.zip && rm vault_linux_amd64.zip && \
  mv vault /bin/vault && \
  chmod 700 /bin/vault && \
  vault version

# Install terraform via tfswitch
RUN curl -sL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash && \
  tfswitch "${TERRAFORM_VERSION}" && \
  terraform -version

# Install helm via helmswitch
RUN curl -sL -o helmswitch-linux-amd64.zip "https://github.com/tokiwong/helm-switcher/releases/download/v${HELMSWITCH_VERSION}/helmswitch-linux-amd64.zip" && \
  unzip helmswitch-linux-amd64.zip && rm helmswitch-linux-amd64.zip && \
  mv helmswitch /bin/helmswitch && \
  chmod 700 /bin/helmswitch && \
  helmswitch "${HELM_VERSION}"

ENTRYPOINT [ "/bin/bash", "-ce" ]
