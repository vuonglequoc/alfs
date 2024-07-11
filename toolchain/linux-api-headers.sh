#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
  echo "Script must be run as user: lfs"
  exit 255
fi

cd $LFS/sources

tar xvf linux-6.7.4.tar.xz

cd linux-6.7.4

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr

cd $LFS/sources

rm -rf linux-6.7.4

echo "Done"
