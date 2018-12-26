#!/bin/bash

exec 2>&1
set -e
set -x

NGINX_VERSION=1.15.8
NGX_CACHE_PURGE_VERSION=2.3
NGX_CACHE_HEADERS_MORE=0.33
NPS_VERSION=1.13.35.1-beta

# Install basic packages and build tools
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
    dpkg-dev \
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libpcre3 \
    libpcre3-dev \
    unzip \
    uuid-dev \
    sed

apt-get source nginx