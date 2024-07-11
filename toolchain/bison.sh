#!/bin/bash

cd /sources/

tar xvf bison-3.8.2.tar.xz

cd bison-3.8.2

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2

make

make install

cd /sources/

rm -rf bison-3.8.2

echo "Done"
