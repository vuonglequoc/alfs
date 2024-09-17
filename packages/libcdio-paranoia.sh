#!/bin/bash

KPKG_SRC_FILE=libcdio-paranoia-10.2+2.0.2.tar.bz2
KPKG_SRC_FOLDER=libcdio-paranoia-10.2+2.0.2

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  make check
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install
}
