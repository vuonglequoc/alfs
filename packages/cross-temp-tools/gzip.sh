#!/bin/bash

KPKG_SRC_FILE=gzip-1.13.tar.xz
KPKG_SRC_FOLDER=gzip-1.13

k_configure() {
  ./configure --prefix=/usr \
              --host=$LFS_TGT
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install
}
