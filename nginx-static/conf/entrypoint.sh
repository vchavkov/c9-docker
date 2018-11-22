#!/bin/bash

set -o errexit
set -o pipefail

echo "===> Start supervisor"
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
