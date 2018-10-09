#!/bin/bash

docker rm -f $(docker ps -a -q);

# DOCKER_IMAGE="$(docker build . --no-cache | grep "Successfully built" | cut -d " " -f3)"
DOCKER_IMAGE="$(docker build . | grep "Successfully built" | cut -d " " -f3)"

docker run -it \
  --name sftp \
  -p 22222:22222 \
  -v sftp-data:/data \
  ${DOCKER_IMAGE} \
  /bin/sh -c "/opt/sftpd/bin/sftpd.sh run"
