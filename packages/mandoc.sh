#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=mandoc-1.14.6.tar.gz
SRC_FOLDER=mandoc-1.14.6

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

./configure

make mandoc

make regress

install -vm755 mandoc   /usr/bin &&
install -vm644 mandoc.1 /usr/share/man/man1

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
