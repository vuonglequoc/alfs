#!/bin/bash

KPKG_SRC_FILE=zlib-1.3.1.tar.gz
KPKG_SRC_FOLDER=zlib-1.3.1

k_configure() {
  ./configure --prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  rm -fv $KPKG_TMP_DIR/usr/lib/libz.a
}
