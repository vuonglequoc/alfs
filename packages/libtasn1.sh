#!/bin/bash

KPKG_SRC_FILE=libtasn1-4.19.0.tar.gz
KPKG_SRC_FOLDER=libtasn1-4.19.0

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install
  make DESTDIR=$KPKG_TMP_DIR -C doc/reference install-data-local
}
