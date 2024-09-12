#!/bin/bash

KPKG_SRC_FILE=xz-5.6.2.tar.xz
KPKG_SRC_FOLDER=xz-5.6.2

k_configure() {
  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --disable-static                  \
              --docdir=/usr/share/doc/xz-5.6.2
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  rm -v $KPKG_TMP_DIR/$LFS/usr/lib/liblzma.la
}
