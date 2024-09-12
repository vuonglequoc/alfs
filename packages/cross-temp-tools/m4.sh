#!/bin/bash

KPKG_SRC_FILE=m4-1.4.19.tar.xz
KPKG_SRC_FOLDER=m4-1.4.19

k_configure() {
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install
}
