#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=popt-1.19.tar.gz
SRC_FOLDER=popt-1.19

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

./configure --prefix=/usr --disable-static

make
make check
make install

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
