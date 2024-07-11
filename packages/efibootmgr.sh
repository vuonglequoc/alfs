#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=efibootmgr-18.tar.gz
SRC_FOLDER=efibootmgr-18

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

make EFIDIR=LFS EFI_LOADER=grubx64.efi
make install EFIDIR=LFS

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
