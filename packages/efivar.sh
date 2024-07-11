#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=efivar-39.tar.gz
SRC_FOLDER=efivar-39

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

make
make install LIBDIR=/usr/lib

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
