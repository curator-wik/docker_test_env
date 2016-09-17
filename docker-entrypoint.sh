#!/bin/bash

/usr/sbin/service vsftpd start

CONTAINER_CMD="/curator/prophusion-tests.sh"
. /prophusion-base-entrypoint.sh
