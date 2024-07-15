#!/bin/bash

SRC_FILE=check-0.15.2.tar.gz
SRC_FOLDER=check-0.15.2

k_configure() {
  ./configure --prefix=/usr \
              --disable-static
}

k_install() {
  make docdir=/usr/share/doc/check-0.15.2 install
}

k_pre_record() {
  make DESTDIR=$KPKG_DEST_DIR docdir=/usr/share/doc/check-0.15.2 install
}
