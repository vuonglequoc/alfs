#!/bin/bash

KPKG_SRC_FILE=SDL2-2.30.5.tar.gz
KPKG_SRC_FOLDER=SDL2-2.30.5

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}

k_build() {
  make install
  rm -v /usr/lib/libSDL2*.a
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
  rm -v $KPKG_TMP_DIR/usr/lib/libSDL2*.a
}
