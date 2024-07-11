#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=groff-1.23.0.tar.gz
SRC_FOLDER=groff-1.23.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

PAGE=A4 ./configure --prefix=/usr

make
make check
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
