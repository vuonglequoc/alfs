#!/bin/bash

KPKG_SRC_FILE=libcdio-2.1.0.tar.bz2
KPKG_SRC_FOLDER=libcdio-2.1.0

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  make check -k
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  # libcdio-paranoia
  tar -xf ../libcdio-paranoia-10.2+2.0.2.tar.bz2
  cd libcdio-paranoia-10.2+2.0.2
  ./configure --prefix=/usr --disable-static
  make
  # make check
  make DESTDIR=$KPKG_TMP_DIR install
}
