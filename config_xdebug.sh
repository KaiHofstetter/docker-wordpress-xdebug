#!/bin/bash

if [ ! -f /xdebug_configured ]; then
    echo "=> Xdebug is not configured yet, configuring Xdebug ..."
    echo "xdebug.remote_enable=on" >> /etc/php/5.6/mods-available/xdebug.ini

    if [ -z $XDEBUG_REMOTE_AUTOSTART ]; then
        XDEBUG_REMOTE_AUTOSTART="on"
    fi
    echo "xdebug.remote_autostart=$XDEBUG_REMOTE_AUTOSTART" >> /etc/php/5.6/mods-available/xdebug.ini

    # https://xdebug.org/docs/all_settings#remote_connect_back
    # 1. If enabled, the xdebug.remote_host setting is ignored
    # 2. Doesn't work correctly if Docker for Mac is used
    if [ -z $XDEBUG_REMOTE_CONNECT_BACK ] ; then
        XDEBUG_REMOTE_CONNECT_BACK="off"
    fi
    echo "xdebug.remote_connect_back=$XDEBUG_REMOTE_CONNECT_BACK" >> /etc/php/5.6/mods-available/xdebug.ini

    if [ "$XDEBUG_REMOTE_CONNECT_BACK" != "on" ] && [ "$XDEBUG_REMOTE_CONNECT_BACK" != "On" ]; then
        if [ -z $XDEBUG_HOST ] ; then
            XDEBUG_HOST=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
        fi
        echo "xdebug.remote_host=$XDEBUG_HOST" >> /etc/php/5.6/mods-available/xdebug.ini
        echo "xdebug.remote_port=$XDEBUG_PORT" >> /etc/php/5.6/mods-available/xdebug.ini
    fi

    if ! [ -z $XDEBUG_REMOTE_KEY ] ; then
        echo "xdebug.xdebug.remote_key=$XDEBUG_REMOTE_KEY" >> /etc/php/5.6/mods-available/xdebug.ini
    fi

    touch /xdebug_configured
else
    echo "=> Xdebug is already configured"
fi