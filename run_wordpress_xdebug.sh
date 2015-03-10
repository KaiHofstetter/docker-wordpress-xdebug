#!/bin/sh

./config_xdebug.sh

if [ -d /wordpress_sources ]; then
    echo "=> Moving WordPress sources to /wordpress_sources"
    cp -r /var/www/html/* /wordpress_sources
    rm -r /var/www/html/*
    ln -sf /wordpress_sources/* /var/www/html
fi

./run.sh