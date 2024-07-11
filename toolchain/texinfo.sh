#!/bin/bash

cd /sources/

tar xvf texinfo-7.1.tar.xz

cd texinfo-7.1

./configure --prefix=/usr

make

make install

cd /sources/

rm -rf texinfo-7.1

echo "Done"
