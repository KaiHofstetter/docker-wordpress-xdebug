FROM kaihofstetter/wordpress-cli:4.1.1
MAINTAINER Kai Hofstetter <kai.hofstetter@gmx.de>

# Install plugins
RUN apt-get update && \
    apt-get -y install php5-xdebug

# Configure xdebug
RUN DOCKER_HOST_IP=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}'); \
    echo "xdebug.remote_enable=on" >> /etc/php5/mods-available/xdebug.ini; \
    echo "xdebug.remote_host='$DOCKER_HOST_IP'" >> /etc/php5/mods-available/xdebug.ini

EXPOSE 80 3306 
CMD ["/run.sh"]
