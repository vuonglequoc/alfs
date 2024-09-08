#!/bin/bash

KPKG_SRC_FILE=tar-1.35.tar.xz
KPKG_SRC_FOLDER=tar-1.35

k_configure() {
  FORCE_UNSAFE_CONFIGURE=1  \
  ./configure --prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  make DESTDIR=$KPKG_TMP_DIR -C doc install-html docdir=/usr/share/doc/tar-1.35
}
