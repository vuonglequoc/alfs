#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
  echo "Script must be run as user: lfs"
  exit 255
fi

cd $LFS/sources

tar xvf gzip-1.13.tar.xz

cd gzip-1.13

./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf gzip-1.13

echo "Done"
