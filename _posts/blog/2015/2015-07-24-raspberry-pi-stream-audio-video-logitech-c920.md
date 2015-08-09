---
layout: post
title: Streaming Audio and Video with Logitech C920 and Raspberry Pi
date:   2015-07-24 17:18
categories: technology essays
tags: raspberry-pi
excerpt: ''
---
First, upgrade the Raspberry Pi firmware:

	apt-get install rpi-update raspi-config
	rpi-update
	reboot

Next, test HTTP streaming manually:

	cvlc v4l2:///dev/video0:chroma=h264:width=800:height=600 :input-slave="alsa://hw:1,0" --sout '#transcode{acodec=mp4a,ab=32}:http{mux=ts,dst=:8080}' -vvv1

Then in a VLC client on your computer or phone, open http://pi-address:8080/.

Using the `mp4a` audio codec will allow you to stream from your Mac, PC and iOS devices.

Now, to make it easy to start/stop:

	sudo nano /etc/init.d/vlc

{% highlight linux-config %}
#!/bin/sh

### BEGIN INIT INFO
# Provides:          vlc
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: vlc
# Description:       transport rtp from localhost to http
### END INIT INFO

VLC_USER=pi
VLC_PORT=8080

start()
{
	echo "Starting vlc ..."
	sudo -u $VLC_USER cvlc v4l2:///dev/video0:chroma=h264:width=800:height=600 :input-slave="alsa://hw:1,0" --sout '#transcode{acodec=mp4a,ab=32}:http{mux=ts,dst=:$VLC_PORT}' -vvv > /dev/null 2>&1  &
}

stop()
{
	echo "Stopping vlc ..."
	kill -9 $(pidof vlc) >/dev/null 2>&1
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		stop
		start
		;;
	*)
		echo "Usage: $0 {start|stop|restart}"
		;;
esac

exit 0
{% endhighlight %}

Next:

	sudo chmod 755 /etc/init.d/vlc

To startup automatically:

	sudo update-rc.d vlc defaults

via: [Matthias Bock](https://wiki.matthiasbock.net/index.php/Logitech_C920,_streaming_H.264) and [Lars K.W. Gohlke](http://blog.lgohlke.de/2014/02/09/babyphone-mit-dem-raspberry-pi.html)
