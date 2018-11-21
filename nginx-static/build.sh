#!/bin/bash

IMAGE_TAG="nginx:0.0.1"

NGINX_CACHE_DIR="/tmp/nginx/cache"
mkdir -p ${NGINX_CACHE_DIR}

docker build --rm -t ${IMAGE_TAG} . --no-cache

docker images -q ${IMAGE_TAG} > .docker_image
