#!/bin/bash

KPKG_SRC_FILE=libtool-2.4.7.tar.xz
KPKG_SRC_FOLDER=libtool-2.4.7

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  make -k check
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  rm -fv $KPKG_TMP_DIR/usr/lib/libltdl.a
}
