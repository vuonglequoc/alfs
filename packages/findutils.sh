#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=findutils-4.9.0.tar.xz
SRC_FOLDER=findutils-4.9.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

chown -Rv tester .
su tester -c "PATH=$PATH make check"

make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
