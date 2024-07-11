#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=automake-1.16.5.tar.xz
SRC_FOLDER=automake-1.16.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

make
make -j$(($(nproc)>4?$(nproc):4)) check
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
