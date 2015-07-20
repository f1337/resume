---
layout: post
title: Rebuilding the Android NDK for Objective-C Support
date: 2011-11-19 18:01:25.000000000 -08:00
categories: technology essays
tags:
- android
- ios
- linux
- objective-c
- os x
status: publish
type: post
published: true
---
How to make the Android NDK compile Objective-C! Many thanks to Jackie Gleason ([@LifeIsTooShort](http://twitter.com/LifeIsTooShort)) for his [M3 Conference](http://www.m3conf.com/) ([@M3Conf](https://twitter.com/#!/M3Conf)) presentation, [Adding Objective-C Support to the Android NDK](https://docs.google.com/present/view?id=dfj692w3_351gq89x8fv), upon which most of this tutorial is based.

### Download and Patch the Android NDK Toolchain Sources

Using the terminal, create a directory for your toolchain sources:

	mkdir -p ~/SDKs/Android/toolchain-src
	cd ~/SDKs/Android/toolchain-src

**IMPORTANT: The build-gcc script expects a specific layout for the source directory. Create the above directory anywhere you like, but be sure to create the subdirectories below exactly as described.**
Next, fetch the sources:

	git clone https://android.googlesource.com/toolchain/build.git
	git clone https://android.googlesource.com/toolchain/gmp.git
	git clone https://android.googlesource.com/toolchain/gdb.git
	git clone https://android.googlesource.com/toolchain/mpc.git
	git clone https://android.googlesource.com/toolchain/mpfr.git
	mkdir binutils
	cd binutils/
	curl -O ftp://sourceware.org//pub/binutils/snapshots/binutils-2.22.51.tar.bz2
	tar xjfv binutils-2.22.51.tar.bz2
	cd ../
	mkdir gcc
	cd gcc/
	curl -O ftp://ftp.gnu.org//gnu/gcc/gcc-4.6.1/gcc-4.6.1.tar.bz2
	tar xjfv gcc-4.6.1.tar.bz2
	cd ../

Patch the toolchain makefile:

	git clone git://gist.github.com/1378127.git build-patch
	cd build/
	patch < ../build-patch/Makefile.in.diff
	cd ../

Patch GCC:

	cd gcc/
	curl http://gcc.gnu.org/bugzilla/attachment.cgi?id=24879 > gcc-4.6.1.patch
	cd gcc-4.6.1/
	patch -p1 < ../gcc-4.6.1.patch

### Download and Patch the Android NDK

Using the terminal, fetch the NDK:

	cd ~/SDKs/Android/
	curl -O http://dl.google.com/android/ndk/android-ndk-r6-darwin-x86.tar.bz2
	tar xjfv android-ndk-r6-darwin-x86.tar.bz2

Next, patch the build-gcc script:

	git clone git://gist.github.com/1378122.git android-ndk-build-gcc-patch
	cd android-ndk-r6/build/tools/
	patch < ../../../android-ndk-build-gcc-patch/build-gcc.sh.diff

### Build the Android NDK Toolchain

Using the terminal, get to the NDK build/tools directory:

	cd ~/SDKs/Android/android-ndk-r6/build/tools/

Next, rebuild GCC on Mac OS X:

	./build-gcc.sh --gmp-version=4.2.4 --mpfr-version=2.4.1 --binutils-version=2.22.51 --try-64 ~/SDKs/Android/toolchain-src ~/SDKs/Android/android-ndk-r6 arm-linux-androideabi-4.6.1

Or rebuild GCC on Linux:

	./build-gcc.sh --gmp-version=4.2.4 --mpfr-version=2.4.1 --mpc-version=0.8.1 --binutils-version=2.22.51 --try-64 ~/SDKs/Android/toolchain-src ~/SDKs/Android/android-ndk-r6 arm-linux-androideabi-4.6.1

### Acknowledgements

* [Adding Objective-C Support to the Android NDK](https://docs.google.com/present/view?id=dfj692w3_351gq89x8fv). Gleason, Jackie. M3 Conference. 19 Nov. 2011.
* [Building an Android NDK with Recent GCC and Binutils](http://glandium.org/blog/?p=2146). Hommey, Mike. Glandium. 1 Aug. 2011.
* [Compiling GCC 4.6.1 on Mac OSX Lion](http://solarianprogrammer.com/2011/09/20/compiling-gcc-4-6-1-on-mac-osx-lion/). Solarian Programmer. 20 Sep. 2011.
* [Android NDK GCC 4.2.1 with Objective C 2.0 Support](http://code.google.com/p/android-gcc-objc2-0/). phausler@gmail.com. 19 Jan. 2010.
