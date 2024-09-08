#!/bin/bash

KPKG_SRC_FILE=expat-2.6.0.tar.xz
KPKG_SRC_FOLDER=expat-2.6.0

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/expat-2.6.0
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -v -m644 doc/*.{html,css} $KPKG_TMP_DIR/usr/share/doc/expat-2.6.0
}
