---
layout: blog
title: "WebIOPi on Raspberry Pi"
date:   2015-07-18 16:59:00
category: blog
tags: raspberry-pi
---

Install WebIOPi:

	cd ~
	curl -O http://sourceforge.net/projects/webiopi/files/WebIOPi-0.7.1.tar.gz
	tar xvzf WebIOPi-0.7.1.tar.gz
	cd WebIOPi-0.7.1/
	sudo ./setup.sh
	Do you want to access WebIOPi over Internet ? [y/n] n

Change the default username and password:

	sudo webiopi-passwd

Change default port, doc-root, etc:

	sudo nano /etc/webiopi/config

Test the installation succeeded:

	sudo webiopi -d -c /etc/webiopi/config

Run as a service:

	sudo /etc/init.d/webiopi start

Ensure service runs at boot:

	sudo update-rc.d webiopi defaults

Source: [http://forums.connectedly.com/raspberry-pi-f179/how-controlling-gpio-pins-via-internet-2884/](http://forums.connectedly.com/raspberry-pi-f179/how-controlling-gpio-pins-via-internet-2884/)
