#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=zstd-1.5.5.tar.gz
SRC_FOLDER=zstd-1.5.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

make prefix=/usr
make check
make prefix=/usr install

rm -v /usr/lib/libzstd.a

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
