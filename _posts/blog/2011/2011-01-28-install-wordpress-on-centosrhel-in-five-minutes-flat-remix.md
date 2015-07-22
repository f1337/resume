---
layout: post
title: Install WordPress on CentOS/RHEL in Five Minutes Flat (remix)
date: 2011-01-28 23:03:27.000000000 -08:00
categories: technology essays
tags:
- apache
- centos
- php
- rhel
- wordpress
status: publish
type: post
published: true
excerpt: ''
---
### Install the System Prerequisites

	yum install mysql-server httpd nano php php-mysql
	chkconfig httpd on
	chkconfig mysqld on
	service mysqld start
	service httpd start

### Create the Database

	mysqladmin create wordpress
	mysql

{% highlight mysql %}
mysql> GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'please+use+a+strong+password';
mysql> FLUSH PRIVILEGES;
mysql> quit
{% endhighlight %}

### Download and Install WordPress

	cd /var/www/
	mkdir wordpress
	cd wordpress
	curl -O http://wordpress.org/latest.tar.gz
	tar xvfz latest.tar.gz
	rm latest.tar.gz
	mv wordpress/ public
	mkdir logs public/wp-content/uploads public/wp-content/cache
	chown apache:apache logs public/wp-content/uploads public/wp-content/cache
	cd public/

### Configure WordPress

Create the WordPress config file outside web root:

	mv wp-config-sample.php ../wp-config.php
	curl https://api.wordpress.org/secret-key/1.1/salt/

Copy the output to your clipboard before editing wp-config.php.

	nano ../wp-config.php

{% highlight php %}
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'enter+the+strong+password+you+defined');
define('DB_HOST', 'localhost');
{% endhighlight %}

&hellip;

{% highlight php %}
define('AUTH_KEY', 'pasted from clipboard');
define('SECURE_AUTH_KEY', 'pasted from clipboard');
define('LOGGED_IN_KEY', 'pasted from clipboard');
define('NONCE_KEY', 'pasted from clipboard');
define('AUTH_SALT', 'pasted from clipboard');
define('SECURE_AUTH_SALT', 'pasted from clipboard');
define('LOGGED_IN_SALT', 'pasted from clipboard');
define('NONCE_SALT', 'pasted from clipboard');
{% endhighlight %}

### Configure Apache

	nano /etc/httpd/conf.d/wordpress.conf

{% highlight apache %}
NameVirtualHost *:80
<VirtualHost *:80>
	ServerAdmin webmaster@dummy-host.example.com
	DocumentRoot /var/www/wordpress/public
	ServerName dummy-host.example.com
	ErrorLog /var/www/wordpress/logs/error_log
	CustomLog /var/www/wordpress/logs/access_log common
	<Directory /var/www/wordpress/public/wp-content>
		Options FollowSymLinks # for pretty permalink support
		RemoveHandler .php
		RemoveType text/html .php
{% endhighlight %}

	service httpd restart

### Acknowledgements

[How to Install WordPress on CentOS 5 in Five Minutes Flat](http://blog.adlibre.org/technology/how-to-install-wordpress-on-centos-5-in-five-minutes-flat.html). Cutler, Andrew. Adlibre. 2010.
