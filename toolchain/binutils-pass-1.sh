#!/bin/bash

SRC_FILE=binutils-2.42.tar.xz
SRC_FOLDER=binutils-2.42

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
               --enable-default-hash-style=gnu
}

k_check() {
  :
}
