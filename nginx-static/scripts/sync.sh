#!/bin/bash

TARGET_HOST="${TARGET_HOST}"
TARGET_HOST="chavkov.com"

rsync -av --delete ./ --exclude="sync.sh" root@${TARGET_HOST}:nginx/

rsync -av --delete ../conf/etc/nginx/sites-enabled/ root@${TARGET_HOST}:/etc/nginx/sites-enabled/
rsync -av --delete ../conf/etc/nginx/conf.d/ root@${TARGET_HOST}:/etc/nginx/conf.d/
rsync -av --delete ../conf/etc/nginx/snippets/ root@${TARGET_HOST}:/etc/nginx/snippets/
rsync -av ../conf/etc/nginx/nginx.conf root@${TARGET_HOST}:/etc/nginx/nginx.conf