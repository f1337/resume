---
layout: post
title: 'Google Blog Converters: blogger2wordpress'
date: 2011-12-28 12:04:11.000000000 -08:00
categories: technology essays
tags:
- blogger
- google
- os x
- python
- wordpress
status: publish
type: post
published: true
excerpt: ''
---
Yesterday, while using the [Google Blog Converters](http://code.google.com/p/google-blog-converters-appengine) to migrate a blog from Blogger to WordPress (see the "Plan B" section of [Migrating an old Blogger blog to WordPress](http://artlung.com/blog/2010/03/02/migrating-an-old-blogger-blog-to-wordpress/)), I encountered the following error:

	$ google-blog-converters-r89/bin/blogger2wordpress.sh blog-12-27-2011.xml > wordpress-blog-12-27-2011.xml
	Traceback (most recent call last):
		File "google-blog-converters-r89/bin/../src/blogger2wordpress/b2wp.py", line 28, in <module>
			import wordpress
		File "/Users/username/Downloads/google-blog-converters-r89/src/blogger2wordpress/wordpress.py", line 55, in <module>
			element_tree_write = ElementTree.ElementTree._write
	AttributeError: type object 'ElementTree' has no attribute '_write'

A quick search led me to an [open issue](http://code.google.com/p/google-blog-converters-appengine/issues/detail?id=77) on the Google Blog Converters site, but no solutions were provided. I did a little more research, and realized I had overlooked the fact that because the Google Blog Converters are built for Google's App Engine, they require Python 2.5, and that more recent versions -- say, the Python 2.7.1 provided with OS X "Lion" -- may not work with the scripts provided. Another quick search (for "python 2.5 lion") led me to [a Stack Overflow post](http://stackoverflow.com/questions/6920278/configuring-python-for-gae-with-lion) where I learned that Apple provides Python 2.5 for Lion, with a custom binary at `/usr/bin/python2.5`. With that information, I was able to fix the blogger2wordpress.sh script by changing line 13 from:

	PYTHONPATH=${PROJ_DIR}/lib python ${PROJ_DIR}/src/blogger2wordpress/b2wp.py $*

to:

	PYTHONPATH=${PROJ_DIR}/lib python2.5 ${PROJ_DIR}/src/blogger2wordpress/b2wp.py $*

I ran the script after the change, and it worked as expected. I hope this helps someone out there, though YMMV.
