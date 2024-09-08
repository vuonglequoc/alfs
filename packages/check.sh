#!/bin/bash

KPKG_SRC_FILE=check-0.15.2.tar.gz
KPKG_SRC_FOLDER=check-0.15.2

k_configure() {
  ./configure --prefix=/usr \
              --disable-static
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR docdir=/usr/share/doc/check-0.15.2 install
}
