# dockerfile-devops-utilities

Dockerfile that contains various devops tools and utilities, that is very helpful for devops in day to day work.

# Docker image Contents

1. Terraform
2. Helm
3. Vault
4. Kubectl
5. Jq

and many more or you can also add more as per your requirement.

# Default versions:

Thease are the default version that we are using, you can update it while building the docker image.
`ARG HELM_VERSION="2.16.11"
ARG TERRAFORM_VERSION="0.15.0"
ARG KUBECTL_VERSION="1.18.0"
ARG VAULT_VERSION="1.7.1"
`

# How to run:

1. Build Image
`docker built -t devops-utilities`
2. Run Docker Image
`docker run --rm -it devops-utilities:latest bash`

You can also use this image in this CI/CD pipeline to work on terraform, helm, vault , kubectl etc and you can also add more DevOps utilities as per your need.

# For local testing

You can aslo do local testing with this image on terraform, helm, vault , kubectl etc without installing it on your system. You can use docker bind mount volume to inject your data into container that you can play with it.

# Note

We are using helmswitch and terraform switch so dont worry about the versions switching, you can easily update the versions in the docker arguments.
