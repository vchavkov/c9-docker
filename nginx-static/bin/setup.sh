#!/bin/bash

exec 2>&1
set -e
set -x

# Install basic packages and build tools
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
    supervisor \
    openssh-server \
    dnsmasq \
    curl \
    wget \
    htop \
    dnsutils \
    sed \
    vim-tiny

ROOT_PASS="mn2111td"

mkdir /var/run/sshd
echo "root:${ROOT_PASS}" | chpasswd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# NOTVISIBLE "in users profile"
echo "export VISIBLE=now" >> /etc/profile

# nginx
/tmp/nginx-make.sh

# Forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

# volumes
mkdir -p /var/cache/nginx
chown www-data:www-data -R /var/cache/nginx

# reduce docker image size
cd /
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb
