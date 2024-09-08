#!/bin/bash

KPKG_SRC_FILE=libvorbis-1.3.7.tar.xz
KPKG_SRC_FOLDER=libvorbis-1.3.7

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  make -j1 check
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m644 doc/Vorbis* $KPKG_TMP_DIR/usr/share/doc/libvorbis-1.3.7
}
