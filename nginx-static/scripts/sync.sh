#!/bin/bash

rsync -av --delete --stats ./ --exclude="sync.sh" root@192.168.3.114:nginx/
rsync -av --delete --stats ./ --exclude="sync.sh" root@192.168.3.114:/etc/nginx/site-enabled/