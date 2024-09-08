#!/bin/bash

KPKG_SRC_FILE=pkgconf-2.1.1.tar.xz
KPKG_SRC_FOLDER=pkgconf-2.1.1

k_configure() {
./configure --prefix=/usr              \
            --disable-static           \
            --docdir=/usr/share/doc/pkgconf-2.1.1
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  ln -sv pkgconf   $KPKG_TMP_DIR/usr/bin/pkg-config
  ln -sv pkgconf.1 $KPKG_TMP_DIR/usr/share/man/man1/pkg-config.1
}
