#!/bin/bash

KPKG_SRC_FILE=zstd-1.5.5.tar.gz
KPKG_SRC_FOLDER=zstd-1.5.5

k_configure() {
  :
}

k_build() {
  make prefix=/usr
}

k_install() {
  make prefix=/usr install
}

k_post_install() {
  rm -v /usr/lib/libzstd.a
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR prefix=/usr install

  rm -v $KPKG_TMP_DIR/usr/lib/libzstd.a
}
