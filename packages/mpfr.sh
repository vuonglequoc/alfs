#!/bin/bash

SRC_FILE=mpfr-4.2.1.tar.xz
SRC_FOLDER=mpfr-4.2.1

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

k_install() {
  make install
  make install-html
}

k_pre_record() {
  make DESTDIR=$KPKG_DEST_DIR install
  make DESTDIR=$KPKG_DEST_DIR install-html
}
