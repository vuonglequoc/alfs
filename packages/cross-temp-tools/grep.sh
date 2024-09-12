#!/bin/bash

KPKG_SRC_FILE=grep-3.11.tar.xz
KPKG_SRC_FOLDER=grep-3.11

k_configure() {
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./build-aux/config.guess)
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install
}
