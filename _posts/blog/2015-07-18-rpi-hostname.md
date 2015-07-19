---
layout: blog
title: "Change Raspberry Pi Hostname"
date:   2015-07-18 16:11:00
category: blog
tags: raspberry-pi
---

	sudo nano /etc/hostname

Change 'raspberrypi' to your custom hostname. <Cntrl>-x to exit. 'Y' to save.

	sudo /etc/init.d/hostname.sh
	sudo reboot

Source: [http://www.howtogeek.com/167195/how-to-change-your-raspberry-pi-or-other-linux-devices-hostname/](http://www.howtogeek.com/167195/how-to-change-your-raspberry-pi-or-other-linux-devices-hostname/)
