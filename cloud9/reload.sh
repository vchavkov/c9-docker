#!/bin/bash

if [ "$1" = "" ]; then
	echo "Docker image id is required."
    exit 11;
fi

DOCKER_IMAGE_ID=${1};

docker rm -f $(docker ps -a -q);

# create cloud9 container
docker run -it -d --restart=always -p 40000:80 --name vchavkov -e C9_USER=vchavkov -e C9_PASS=aiTh3oop -v /ghost:/workspace ${DOCKER_IMAGE_ID}
docker run -it -d --restart=always -p 50000:80 --name design -e C9_USER=design -e C9_PASS=Phee7iu9 -v /design:/workspace ${DOCKER_IMAGE_ID}
docker run -it -d --restart=always -p 60000:80 --name training -e C9_USER=training -e C9_PASS=Phee7iu9 -v /ghost/customer/training:/workspace ${DOCKER_IMAGE_ID}
docker run -it -d --restart=always -p 31000:80 --name ndemirev -e C9_USER=ndemirev -e C9_PASS=jo2eeLah -v /ghost/customer:/workspace ${DOCKER_IMAGE_ID}
docker run -it -d --restart=always -p 31001:80 --name asaraliyski -e C9_USER=asaraliyski -e C9_PASS=Eijo6eek -v /ghost/customer/asaraliyski:/workspace ${DOCKER_IMAGE_ID}