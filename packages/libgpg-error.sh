#!/bin/bash

KPKG_SRC_FILE=libgpg-error-1.50.tar.bz2
KPKG_SRC_FOLDER=libgpg-error-1.50

k_configure() {
  ./configure --prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m644 -D README $KPKG_TMP_DIR/usr/share/doc/libgpg-error-1.50/README
}
