FROM tutum/wordpress:latest
MAINTAINER Kai Hofstetter <kai.hofstetter@gmx.de>

# Install plugins
RUN apt-get update && \
    apt-get -y install php5-xdebug

# Configure xdebug
RUN echo "xdebug.remote_enable=on" >> /etc/php5/mods-available/xdebug.ini; \
    echo "xdebug.remote_connect_back=on" >> /etc/php5/mods-available/xdebug.ini

EXPOSE 80 3306 
CMD ["/run.sh"]
