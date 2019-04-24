#!/bin/bash

rsync -av --delete ./ --exclude="sync.sh" root@192.168.3.114:nginx/

rsync -av --delete ../conf/etc/nginx/sites-enabled/ root@192.168.3.114:/etc/nginx/sites-enabled/
rsync -av --delete ../conf/etc/nginx/conf.d/ root@192.168.3.114:/etc/nginx/conf.d/
rsync -av --delete ../conf/etc/nginx/snippets/ root@192.168.3.114:/etc/nginx/snippets/
rsync -av ../conf/etc/nginx/nginx.conf root@192.168.3.114:/etc/nginx/nginx.conf