#!/bin/bash

if [ ! -f /xdebug_configured ]; then
    echo "=> Xdebug is not configured yet, configuring Xdebug ..."
    DOCKER_HOST_IP=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
    echo "xdebug.remote_enable=on" >> /etc/php5/mods-available/xdebug.ini
    echo "xdebug.remote_host=$DOCKER_HOST_IP" >> /etc/php5/mods-available/xdebug.ini
    echo "xdebug.remote_port=$XDEBUG_PORT" >> /etc/php5/mods-available/xdebug.ini

    touch /xdebug_configured
else
    echo "=> Xdebug is already configured"
fi