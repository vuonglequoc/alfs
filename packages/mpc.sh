#!/bin/bash

SRC_FILE=mpc-1.3.1.tar.gz
SRC_FOLDER=mpc-1.3.1

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/mpc-1.3.1
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
