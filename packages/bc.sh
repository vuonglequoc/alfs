#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=bc-6.7.5.tar.xz
SRC_FOLDER=bc-6.7.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

CC=gcc ./configure --prefix=/usr -G -O3 -r

make
make test
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
