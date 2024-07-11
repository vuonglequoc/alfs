#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=kmod-31.tar.xz
SRC_FOLDER=kmod-31

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --with-openssl         \
            --with-xz              \
            --with-zstd            \
            --with-zlib

make

make install

for target in depmod insmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /usr/sbin/$target
done

ln -sfv kmod /usr/bin/lsmod

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
