#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cd /sources

tar xvf man-pages-6.06.tar.xz

cd man-pages-6.06

rm -v man3/crypt*

make prefix=/usr install

cd /sources

rm -rf man-pages-6.06

echo "Done"
