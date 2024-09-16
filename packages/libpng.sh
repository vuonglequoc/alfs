#!/bin/bash

KPKG_SRC_FILE=libpng-1.6.43.tar.xz
KPKG_SRC_FOLDER=libpng-1.6.43

k_pre_configure() {
  gzip -cd ../libpng-1.6.43-apng.patch.gz | patch -p1
}

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/share/doc/libpng-1.6.43
  cp -v README libpng-manual.txt $KPKG_TMP_DIR/usr/share/doc/libpng-1.6.43
}
