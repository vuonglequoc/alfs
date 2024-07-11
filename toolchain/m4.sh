\#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
  echo "Script must be run as user: lfs"
  exit 255
fi

cd $LFS/sources

tar xvf m4-1.4.19.tar.xz

cd m4-1.4.19

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf m4-1.4.19

echo "Done"
