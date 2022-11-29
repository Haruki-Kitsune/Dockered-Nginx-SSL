#!/bin/sh
# This file needs to be called by crontab.
# The following line needs to be added to the crontab:
# 0 0 * * 6 sh /path/to/docker-compose-file/renew.sh
# This will try to renew the certificate every saterday.

set -e

cd /path/to/docker-compose-file
/usr/local/bin/docker-compose -f docker-compose.deploy.yml run --rm certbot renew
