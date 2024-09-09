#!/bin/bash

KPKG_SRC_FILE=binutils-2.43.1.tar.xz
KPKG_SRC_FOLDER=binutils-2.43.1

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../configure --prefix=$LFS/tools \
               --with-sysroot=$LFS \
               --target=$LFS_TGT   \
               --disable-nls       \
               --enable-gprofng=no \
               --disable-werror    \
               --enable-new-dtags  \
               --enable-default-hash-style=gnu
}

k_check() {
  :
}
