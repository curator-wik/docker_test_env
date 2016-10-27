#!/bin/bash

/usr/sbin/service vsftpd start

CONTAINER_CMD="/curator/prophusion-tests.sh"

# If xdebug connect back to the docker host is requested, set environment
if [ "$DOCKER_REMOTE_XDEBUG" == "1" ]
then
  HOST_IP=$(/sbin/ip -4 route list 0/0 | /usr/bin/awk '/default/ { print $3 }')
  XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_host=$HOST_IP remote_port=9000"
  echo $XDEBUG_CONFIG
  export XDEBUG_CONFIG

  IDE_PHPUNIT_CUSTOM_LOADER="$PHPUNIT"
  export IDE_PHPUNIT_CUSTOM_LOADER
  cp /host_tmp/ide-phpunit.php /tmp
  PHPUNIT="php /tmp/ide-phpunit.php"
  export PHPUNIT
fi

. /prophusion-base-entrypoint.sh
