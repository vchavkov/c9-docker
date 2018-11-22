#!/bin/bash

set -o errexit
set -o pipefail

echo -e "\n===> updated /etc/resolv.conf\n"
echo "
nameserver 127.0.0.1
search minerva.net
" > /etc/resolv.conf

cat /etc/resolv.conf

echo -e "===> start supervisor\n"
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
