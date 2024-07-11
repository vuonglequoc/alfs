#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=expat-2.6.0.tar.xz
SRC_FOLDER=expat-2.6.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.6.0

make
make check
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.6.0

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
