---
layout: post
title: How to Move a Github Repository to Your Private RHEL or CentOS Server
date: 2011-01-28 23:15:58.000000000 -08:00
categories:
- essays
tags:
- centos
- git
- rhel
- ssh
status: publish
type: post
published: true
---
### Install Git on Your Private RHEL or CentOS Server
If you don't use RHEL or CentOS, or if Git is already installed on your server, please skip ahead.
First, [install the appropriate EPEL repository](http://fedoraproject.org/wiki/EPEL/FAQ#Using_EPEL) on your server:
`# curl -O http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm`
`# yum --nogpgcheck install epel-release-5-4.noarch.rpm`
Next, install Git:
`# yum install git`
### Create a Bare Clone of the Existing Repository
From your local machine:
`$ git clone --bare git@github.com:username/project.git ./project.git`
A bare repository is one without a working copy of the code: it only contains the repository's Git database. A bare repository on the server will prevent you from accidentally introducing working copy conflicts.
### Copy the Bare Repository to Your Private Server
From your local machine:
`$ tar cvfz project.tgz project.git/`
`$ scp project.tgz user@hostname:project.tgz`
`$ ssh user@hostname`  
From your server:
`# adduser git`
`# mv project.tgz /home/git/`
`# cd /home/git/`
`# tar xvfz project.tgz`
`# rm project.tgz`  
### Configure SSH+Git Permissions
From your server:
`# chmod g+rx /home/git`
`# usermod -a -G git user`
`# chown -R git:git project.git/`
`# cd project.git/`
`# git --bare init --shared=group`
`# chmod g+ws branches hooks info objects objects/* refs`
`# exit`
### Clone a New Working Copy from Your Private Server
From your local machine:
`$ git clone ssh://user@host/home/git/project.git`
### Update "Origin" of Existing Working Copies
From your local machine:
`$ git remote rm origin`
`$ git remote add origin ssh://user@host/home/git/project.git`
### Acknowledgements
[How to Publish a Git Repository](http://www.bluishcoder.co.nz/2007/09/how-to-publish-git-repository.html). Double, Chris. Bluish Coder. 22 Sep. 2007.
[Git - Howto Setup Shared Repository with SSH Access](http://eagleas.livejournal.com/18907.html). Eagleas. Live Journal. 26 Jun. 2008.
[Howto: Linux Add User to Group](http://www.cyberciti.biz/faq/howto-linux-add-user-to-group/). Gite, Vivek. nixCraft. 14 Mar. 2006.
[Switch “Origin” of Your Git Repository](http://blog.aplikacja.info/2010/08/switch-origin-of-your-git-repository/). Cieslak, Dariusz. Aplikacja.info. 10 Aug. 2010.
