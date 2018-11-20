#!/bin/bash

NGINX_CACHE_DIR="/tmp/nginx/cache"
mkdir -p ${NGINX_CACHE_DIR}

docker rm -f $(docker ps -a -q);

# DOCKER_IMAGE="$(docker build . --no-cache | grep "Successfully built" | cut -d " " -f3)"

DOCKER_IMAGE="$(docker build . | grep "Successfully built" | cut -d " " -f3)"

docker run -it \
  --name nginx \
  -p 88:80 \
  -p 8443:443 \
  -v $NGINX_CACHE_DIR:/var/cache/nginx \
  ${DOCKER_IMAGE} \
  /bin/bash
