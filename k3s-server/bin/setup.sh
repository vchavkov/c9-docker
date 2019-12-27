#!/bin/bash

exec 2>&1
set -e
set -x

K3S_VERSION=0.9.1

# Install basic packages and build tools
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
    ca-certificates \
    curl \
    vim-tiny

curl -Lo /usr/local/bin/k3s https://github.com/rancher/k3s/releases/download/v${K3S_VERSION}/k3s
chmod +x /usr/local/bin/k3s

# Forward request and error logs to docker log collector
# ln -sf /dev/stdout /var/log/nginx/access.log
# ln -sf /dev/stderr /var/log/nginx/error.log

# reduce docker image size
cd /
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb
