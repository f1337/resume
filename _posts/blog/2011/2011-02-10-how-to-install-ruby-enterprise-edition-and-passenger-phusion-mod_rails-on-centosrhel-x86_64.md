---
layout: post
title: How to Install Ruby Enterprise Edition and Passenger Phusion (mod_rails) on CentOS/RHEL x86_64
date: 2011-02-10 10:21:15.000000000 -08:00
categories: technology essays
tags:
- apache
- centos
- linux
- rails
- rhel
- ruby
status: publish
type: post
published: true
excerpt: ''
---
### Install System Prerequisites

Install the prerequisite development headers. If this is a production system, make note of all the packages installed, for future removal.

	yum install apr-devel.x86_64 apr-util-devel.x86_64 curl-devel.x86_64 gcc-c++.x86_64 httpd-devel.x86_64 mysql-devel.x86_64 mysql-server.x86_64 openssl-devel.x86_64 zlib-devel.x86_64

### Install Ruby Enterprise Edition

First, install the [End Point yum repository](https://packages.endpoint.com/):

	yum update m2crypto
	curl -O https://packages.endpoint.com/rhel/5/os/x86_64/endpoint-repo-1.0-1.x86_64.rpm
	yum --nogpgcheck install endpoint-repo-1.0-1.x86_64.rpm

Next, install Ruby and RubyGems:

	yum install ruby-enterprise ruby-enterprise-rubygems

### Install Phusion Passenger (mod_rails)

First, install the [Phusion-provided Passenger repository for CentOS](http://blog.phusion.nl/2011/01/04/phusion-passenger-native-packages-for-redhatfedoracentos/):

	curl -O http://passenger.stealthymonkeys.com/rhel/5/passenger-release.noarch.rpm
	yum --nogpgcheck install passenger-release.noarch.rpm

Next, install Passenger:

	gem install passenger
	passenger-install-apache2-module

### Configure Apache

	nano /etc/httpd/conf.d/mod_rails.conf

{% highlight apache %}
LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.2/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-3.0.2
PassengerRuby /usr/local/bin/ruby
{% endhighlight %}

	nano /etc/httpd/conf.d/myrailsapp.conf

{% highlight apache %}
<VirtualHost *:80>
	ServerAdmin webmaster@dummy-host.example.com
	DocumentRoot /var/www/myrailsapp/public
	ServerName dummy-host.example.com
	ErrorLog /var/www/myrailsapp/log/error_log
	CustomLog /var/www/myrailsapp/log/access_log common
	# mod_rails
	<Directory /var/www/myrailsapp/public>
		RailsEnv production
		Options -Multiviews
{% endhighlight %}

	service httpd restart

### Install Rails via Bundler

	gem update --system
	gem install bundler
	gem install mysql -- --with-mysql-config=/usr/lib64/mysql/mysql_config
	cd /var/www/myrailsapp
	bundle install --without development test
	touch log/production.log
	chgrp apache log/*
	chmod g+w log/*

### Remove Development Packages

If you just deployed to a production environment, you probably don't want compilers, development libraries, headers or packagers leaving you vulnerable to a rootkit exploit:

	yum remove *-devel *-headers gcc-c++ cpp gcc libgomp pkgconfig

### Acknowledgements

* [Deploying to a Virtual Host’s Root](http://www.modrails.com/documentation/Users%20guide%20Apache.html#_deploying_to_a_virtual_host_8217_s_root). Phusion Passenger User's Guide. 5 Dec. 2010.
* [Packaging Ruby Enterprise Edition into RPM](http://blog.endpoint.com/2009/06/ruby-enterprise-edition-rpm-packages.html). Vollrath, Adam. End Point. 16 Jun. 2009.
