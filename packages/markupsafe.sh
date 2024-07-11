#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=MarkupSafe-2.1.5.tar.gz
SRC_FOLDER=MarkupSafe-2.1.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist Markupsafe

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
