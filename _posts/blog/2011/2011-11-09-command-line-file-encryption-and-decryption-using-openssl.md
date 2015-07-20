---
layout: post
title: Command-Line File Encryption and Decryption using OpenSSL
date: 2011-11-09 20:15:37.000000000 -08:00
categories: technology essays
tags:
- centos
- decryption
- encryption
- linux
- os x
- ssl
status: publish
type: post
published: true
---
To encrypt file.txt (you will be prompted for a password):

	openssl aes-256-cbc -salt -in file.txt -out file.txt.enc

To decrypt file.txt.enc (you will be prompted for the password used to encrypt):

	openssl aes-256-cbc -d -in file.txt.enc -out file.txt

via: [Tombuntu](http://tombuntu.com/index.php/2007/12/12/simple-file-encryption-with-openssl/)
