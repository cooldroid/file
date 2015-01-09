#!/bin/sh
ldflags="-static -Wl,--gc-sections"
if test "$1" = "configure"; then
	autoreconf -fi
	sed -i s/"MAGIC = .*"/"MAGIC = \/system\/etc\/magic"/g src/Makefile.in
	chost=arm-linux-gnueabihf
	cflags="-O3 -ffunction-sections -s"
	./configure --host=$chost --disable-shared --enable-static LD=$chost-ld LDFLAGS="$ldflags" CFLAGS="$cflags"
fi
cd src
make all LDFLAGS="-all$ldflags"
cp ./file /sdcard/system/develop/
cd -
echo "Build complete"
