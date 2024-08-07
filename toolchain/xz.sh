#!/bin/bash

KPKG_SRC_FILE=xz-5.4.6.tar.xz
KPKG_SRC_FOLDER=xz-5.4.6

k_configure() {
  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --disable-static                  \
              --docdir=/usr/share/doc/xz-5.4.6
}

k_check() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}

k_post_install() {
  rm -v $LFS/usr/lib/liblzma.la
}
