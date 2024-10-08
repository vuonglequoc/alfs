#!/bin/bash

KPKG_SRC_FILE=make-4.4.1.tar.gz
KPKG_SRC_FOLDER=make-4.4.1

k_configure() {
  ./configure --prefix=/usr   \
              --without-guile \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install
}
