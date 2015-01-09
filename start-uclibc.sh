#!/bin/sh
PATH=~/arm-uclibc/bin:$PATH
CROSS_COMPILE=/root/arm-uclibc/bin/arm-buildroot-linux-uclibcgnueabi-
ldflags="-static -Wl,--gc-sections"
if test "$1" = "configure"; then
	autoreconf -fi
	sed -i s/"MAGIC = .*"/"MAGIC = \/system\/etc\/magic"/g src/Makefile.in
	chost=arm-buildroot-linux-uclibcgnueabi
	cflags="-Os -ffunction-sections -s -I /root/arm-uclibc/include"
	./configure --host=$chost --disable-shared --enable-static LD=$chost-ld LDFLAGS="$ldflags" CFLAGS="$cflags"
fi
cd src
make -j4 all CC=${CROSS_COMPILE}gcc LDFLAGS="-all$ldflags"
cp ./file /sdcard/system/develop/
cd -
echo "Build complete"
