#!/bin/bash

KPKG_SRC_FILE=binutils-2.42.tar.xz
KPKG_SRC_FOLDER=binutils-2.42

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

k_install() {
  make tooldir=/usr install
}

k_post_install() {
  rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR tooldir=/usr install

  rm -fv $KPKG_TMP_DIR/usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a
}
