#!/bin/bash

cd /sources/

tar xvf Python-3.12.2.tar.xz

cd Python-3.12.2

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip

make

make install

cd /sources/

rm -rf Python-3.12.2

echo "Done"
