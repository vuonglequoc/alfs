#!/bin/bash

KPKG_SRC_FILE=zstd-1.5.6.tar.gz
KPKG_SRC_FOLDER=zstd-1.5.6

k_configure() {
  :
}

k_build() {
  make prefix=/usr
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr install

  rm -v $KPKG_TMP_DIR/usr/lib/libzstd.a
}
