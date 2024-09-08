#!/bin/bash

KPKG_SRC_FILE=a52dec-0.8.0.tar.gz
KPKG_SRC_FOLDER=a52dec-0.8.0

k_configure() {
  ./configure --prefix=/usr           \
              --mandir=/usr/share/man \
              --enable-shared         \
              --disable-static        \
              CFLAGS="${CFLAGS:--g -O3} -fPIC"
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  cp liba52/a52_internal.h $KPKG_TMP_DIR/usr/include/a52dec
  install -v -m644 -D doc/liba52.txt \
      $KPKG_TMP_DIR/usr/share/doc/liba52-0.8.0/liba52.txt
}
