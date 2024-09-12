#!/bin/bash

KPKG_SRC_FILE=diffutils-3.10.tar.xz
KPKG_SRC_FOLDER=diffutils-3.10

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
