#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=freetype-2.13.2.tar.xz
SRC_FOLDER=freetype-2.13.2

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

tar -xf ../freetype-doc-2.13.2.tar.xz --strip-components=2 -C docs

sed -ri "s:.*(AUX_MODULES.*valid):\1:" modules.cfg &&

sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" \
    -i include/freetype/config/ftoption.h  &&

./configure --prefix=/usr --enable-freetype-config --disable-static

make

make install

cp -v -R docs -T /usr/share/doc/freetype-2.13.2 &&
rm -v /usr/share/doc/freetype-2.13.2/freetype-config.1

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
