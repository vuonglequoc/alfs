#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=kbd-2.6.4.tar.xz
SRC_FOLDER=kbd-2.6.4

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

patch -Np1 -i ../kbd-2.6.4-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make
make check
make install

cp -R -v docs/doc -T /usr/share/doc/kbd-2.6.4

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
