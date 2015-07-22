---
layout: post
title: Controlling Raspberry Pi GPIO Pins with WebIOPi
date:   2015-07-18 16:59:00
categories: technology essays
tags: raspberry-pi
excerpt: ''
---
### 1. Install WebIOPi

	cd ~
	curl -O http://sourceforge.net/projects/webiopi/files/WebIOPi-0.7.1.tar.gz
	tar xvzf WebIOPi-0.7.1.tar.gz
	cd WebIOPi-0.7.1/
	sudo ./setup.sh
	Do you want to access WebIOPi over Internet ? [y/n] n

### 2. Change the default username and password

	sudo webiopi-passwd

### 3. Change default port, doc-root, etc

	sudo nano /etc/webiopi/config

### 4. Test the installation succeeded

	sudo webiopi -d -c /etc/webiopi/config

### 5. Run as a service

	sudo /etc/init.d/webiopi start

### 6. Ensure service runs at boot

	sudo update-rc.d webiopi defaults

via: [Connectedly Forums](http://forums.connectedly.com/raspberry-pi-f179/how-controlling-gpio-pins-via-internet-2884/)
