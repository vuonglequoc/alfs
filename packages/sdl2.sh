#!/bin/bash

KPKG_SRC_FILE=SDL2-2.30.6.tar.gz
KPKG_SRC_FOLDER=SDL2-2.30.6

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  # cd test &&
  # ./configure &&
  # make

  rm -v $KPKG_TMP_DIR/usr/lib/libSDL2*.a
}
