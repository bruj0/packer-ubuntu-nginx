#!/bin/bash -eu

base_name=${MY_BASE_NAME:-bruj0}
image_name=${MY_IMAGE_NAME:-nginx64}
version=${MY_VERSION:-0.1}
provider=${MY_PROVIDER-virtualbox}
path="box/${provider}/${image_name}-${version}.box"

set +eu
if [ -z "$VAGRANT_CLOUD_TOKEN" ]; then
    echo "==> VAGRANT_CLOUD_TOKEN not set exiting"
    exit 1
fi
set -eu
#VAGRANT_CLOUD_TOKEN dont set this in this file
echo "==> Login to vagrant cloud with the token in the environment VAGRANT_CLOUD_TOKEN"
vagrant cloud auth login

echo "==> Verify we are logged in"
vagrant cloud auth whoami

echo "==> Publish the image"
vagrant cloud publish "${base_name}/${image_name}" ${version} ${provider} ${path}  --release --force
