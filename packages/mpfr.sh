#!/bin/bash

KPKG_SRC_FILE=mpfr-4.2.1.tar.xz
KPKG_SRC_FOLDER=mpfr-4.2.1

k_configure() {
  ./configure --prefix=/usr        \
              --disable-static     \
              --enable-thread-safe \
              --docdir=/usr/share/doc/mpfr-4.2.1
}

k_build() {
  make
  make html
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install
  make DESTDIR=$KPKG_TMP_DIR install-html
}
