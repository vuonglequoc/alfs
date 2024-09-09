#!/bin/bash

KPKG_SRC_FILE=binutils-2.43.1.tar.xz
KPKG_SRC_FOLDER=binutils-2.43.1

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../configure --prefix=/usr       \
              --sysconfdir=/etc   \
              --enable-gold       \
              --enable-ld=default \
              --enable-plugins    \
              --enable-shared     \
              --disable-werror    \
              --enable-64-bit-bfd \
              --enable-new-dtags  \
              --with-system-zlib  \
              --enable-default-hash-style=gnu
}

k_build() {
  make tooldir=/usr
}

k_check() {
  make -k check
  grep '^FAIL:' $(find -name '*.log')
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR tooldir=/usr install

  rm -fv $KPKG_TMP_DIR/usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a
}
