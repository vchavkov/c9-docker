#!/bin/bash

URI="proxy.minerva.net"

DOCKER_IMAGE="$(cat .docker_image)"

docker rm -f nginx;

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
