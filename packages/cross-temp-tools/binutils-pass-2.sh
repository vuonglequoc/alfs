#!/bin/bash

KPKG_SRC_FILE=binutils-2.43.1.tar.xz
KPKG_SRC_FOLDER=binutils-2.43.1

k_pre_configure() {
  sed '6009s/$add_dir//' -i ltmain.sh

  mkdir -v build
  cd       build
}

k_configure() {
  ../configure                   \
      --prefix=/usr              \
      --build=$(../config.guess) \
      --host=$LFS_TGT            \
      --disable-nls              \
      --enable-shared            \
      --enable-gprofng=no        \
      --disable-werror           \
      --enable-64-bit-bfd        \
      --enable-new-dtags         \
      --enable-default-hash-style=gnu
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  rm -v $KPKG_TMP_DIR/$LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
}
