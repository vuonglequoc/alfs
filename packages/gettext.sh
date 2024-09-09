#!/bin/bash

KPKG_SRC_FILE=gettext-0.22.5.tar.xz
KPKG_SRC_FOLDER=gettext-0.22.5

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/gettext-0.22.5
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  chmod -v 0755 $KPKG_TMP_DIR/usr/lib/preloadable_libintl.so
}
