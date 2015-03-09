#!/bin/sh

if [ -d /wordpress_sources ]; then
    echo "=> Linking WordPress sources to /wordpress_sources"
    ln -sf /var/www/html/* /wordpress_sources
fi

./run.sh