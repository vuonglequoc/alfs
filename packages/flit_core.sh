#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=flit_core-3.9.0.tar.gz
SRC_FOLDER=flit_core-3.9.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist flit_core

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
