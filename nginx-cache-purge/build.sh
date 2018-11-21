#!/bin/bash

URI="proxy.minerva.net"

NGINX_CACHE_DIR="/tmp/nginx/cache"
mkdir -p ${NGINX_CACHE_DIR}

docker rm -f $(docker ps -a -q);

# DOCKER_IMAGE="$(docker build --build-arg URI=${URI} . --no-cache | grep "Successfully built" | cut -d " " -f3)"

DOCKER_IMAGE="$(docker build --build-arg URI=${URI} . | grep "Successfully built" | cut -d " " -f3)"

docker run \
-it \
--name nginx \
--hostname=nginx \
--dns=172.31.6.89 \
--dns-search=minerva.net \
--add-host "${URI}":127.0.0.1 \
-p 88:80 \
-p 8443:443 \
-v $NGINX_CACHE_DIR:/var/cache/nginx \
${DOCKER_IMAGE} \
/bin/bash
