# docker-wordpress-xdebug
WordPress Docker image for debugging WordPress, themes or plugins, bundled with MySQL, WordPress CLI and Xdebug. 
Installs an automatically configured, ready to use WordPress. 

The WordPress sources can be mounted to the host file system for debugging the WordPress source code.
Everything needed to run WordPress is included in the image and no manual configuration is needed. 

This image is perfect for debugging WordPress, themes or plugins.

The MySQL database is accessible from the host. 

## How to use it
1. Run WordPress

    ```
    docker run --name my-wordpress -v /path/to/host/wordpress_sources:/wordpress_sources -p 80:80 -d kaihofstetter/wordpress-xdebug
    ```
    
    **Very important!
    The folder '/path/to/host/wordpress_sources' should be empty, except for plugin or theme source code you want to debug. The WordPress sources will be copied to the folder!**
2. Access WordPress

    ```
    http://localhost
    ```

2. Log in to WordPress

    ```
    http://localhost/wp-login.php
    ```

    Username: 'admin_user'
    
    Password: 'secret'

### Using Xdebug
 1. Configure your IDE to listen on port 9000 for Xdebug, or the port you configured via the XDEBUG_PORT environment variable.
 2. Set the source path for debugging in your IDE to the configured '/path/to/host/wordpress_sources'
 3. Set the XDEBUG_SESSION cookie in your browser (e.g. via a browser extension:  https://chrome.google.com/extensions/detail/eadndfjplgieldjbigjakmdgkmoaaaoc)

For more information about remote debugging with Xdebug : [http://xdebug.org/docs/remote](http://xdebug.org/docs/remote)

### Changing the WordPress port
If you don't want to use the default port 80 on the host to access WordPress, besides changing the Docker port mapping (e.g. '...-p 8080:80...'), you also need to change the configured WordPress site URL by setting the WP_URL environment variable (e.g. '...WP_URL="localhost:8080"...').

WordPress needs to know the site URL used by the host, because WordPress redirects to the site URL and uses links to the site URL. 

1. Run WordPress

    ```
    docker run --name my-wordpress -v /path/to/host/wordpress_sources:/wordpress_sources -p 8080:80 -e WP_URL="localhost:8080" -d kaihofstetter/wordpress-xdebug
    ```
2. Access WordPress

    ```
    http://localhost:8080
    ```

### Accessing the MySQL database
Run WordPress with mapped MySQL port 3306:

```
docker run --name my-wordpress -p 80:80 -p 3306:3306 -d kaihofstetter/wordpress-xdebug
```

The MySQL database is accessible via ```port 3306```, ```user: WordPress``` and ```password: secret```.

### Executing WP CLI commands
The included WordPress command line interpreter (WP CLI) can be executed via ```docker exec```:

``` 
docker exec -i -t my-wordpress wp ...
```

For more information about WP CLI commands : [http://wp-cli.org/commands/](http://wp-cli.org/commands/)

###  Environment variables
You can use the following environment variables to configure MySQL and WordPress

* **XDEBUG_PORT** (default is '9000')
  * Port used by Xdebug to connect to IDE 
* **XDEBUG_HOST** (default is auto-detected)
  * Host used by Xdebug to connect to IDE.
    Leave empty by default or set to "docker.for.mac.localhost" if use Docker for Mac.
* **XDEBUG_REMOTE_AUTOSTART** (default is "on")
  * Start a debug session automatically.
* **XDEBUG_REMOTE_CONNECT_BACK** (default is "off")
  * Try to connect to the client that made the HTTP request
   (could be problematic to use with Docker for Mac, use appropriate `XDEBUG_HOST` setting instead)
* **XDEBUG_REMOTE_KEY** (default is empty)
  * IDE Key, for example 'PHPSTORM'
* **MYSQL_WP_USER** (default is 'WordPress')
  * MySQL user, used by WordPress
* **MYSQL_WP_PASSWORD** (default is 'secret')
  * MySQL password, used by WordPress
* **WP_URL** (default is 'localhost')
  * The address of the WordPress site.
* **WP_TITLE** (default is 'WordPress Demo')
  * Title of the WordPress blog
* **WP_ADMIN_USER** (default is 'admin_user')
  * WordPress admin user
* **WP_ADMIN_PASSWORD** (default is 'secret”)
  * WordPress admin password
* **WP_ADMIN_EMAIL** (default is 'test@test.com')
  * WordPress admin email address (WordPress installation does not send emails!)

