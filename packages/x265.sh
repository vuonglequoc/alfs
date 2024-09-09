#!/bin/bash

KPKG_SRC_FILE=x265_3.6.tar.gz
KPKG_SRC_FOLDER=x265_3.6

k_pre_configure() {
  mkdir bld
  cd    bld
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr \
        -W no-dev ../source
}

k_check() {
  :
}

k_pre_install() {
  rm -fv /usr/lib/libx265.so.212
  make DESTDIR=$KPKG_TMP_DIR install

  rm -vf $KPKG_TMP_DIR/usr/lib/libx265.a
}
