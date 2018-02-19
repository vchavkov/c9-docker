#!/bin/bash

if [ "$1" = "" || "$2" = "" ]; then
	echo "cloud9 username and password are required."
    exit 11;
fi

C9_USER=$1;
C9_PASS=$2;

su -c "/home/vchavkov/.nvm/versions/node/v4.8.7/bin/node /home/vchavkov/.cloud9/server.js -s standalone --server-config standalone --server-settings standalone --listen 0.0.0.0 --port 80 -w /ghost -a ${C9_USER}:${C9_PASS}" - vchavkov