#!/bin/bash

SRC_FILE=zstd-1.5.5.tar.gz
SRC_FOLDER=zstd-1.5.5

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
  make DESTDIR=$KPKG_DEST_DIR prefix=/usr install

  rm -v $KPKG_DEST_DIR/usr/lib/libzstd.a
}
