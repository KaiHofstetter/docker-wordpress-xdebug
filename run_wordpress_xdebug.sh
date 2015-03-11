#!/bin/sh

./config_xdebug.sh

if [ -d /wordpress_sources ] && [ ! -f /wordpress_sources_moved ]; then

    echo "=> Moving WordPress sources to /wordpress_sources"
    cp -rp /var/www/html/* /wordpress_sources
    rm -r /var/www/html/*
    ln -sf /wordpress_sources/* /var/www/html

    touch /wordpress_sources_moved
fi

./run.sh