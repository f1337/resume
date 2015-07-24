---
layout: post
title: WiFi Configuration with Hidden SSID for Raspberry Pi
date:   2015-07-23 20:21
categories: technology essays
tags: raspberry-pi
excerpt: ''
---
	sudo nano /etc/network/interfaces

{% highlight linux-config %}
auto wlan0

iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
{% endhighlight %}

	sudo nano /etc/wpa_supplicant/wpa_supplicant.conf

{% highlight linux-config %}
network={
	ssid="SSID"
	scan_ssid=1
	psk="secret"
	proto=RSN
	key_mgmt=WPA-PSK
	pairwise=CCMP
	auth_alg=OPEN
}
{% endhighlight %}
