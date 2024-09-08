#!/bin/bash

KPKG_SRC_FILE=binutils-2.42.tar.xz
KPKG_SRC_FOLDER=binutils-2.42

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
      --enable-default-hash-style=gnu
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_install() {
  make DESTDIR=$LFS install
}

k_post_install() {
  rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
}
