#!/bin/bash

KPKG_SRC_FILE=gcc-14.2.0.tar.xz
KPKG_SRC_FOLDER=gcc-14.2.0

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../libstdc++-v3/configure      \
      --prefix=/usr              \
      --host=$LFS_TGT            \
      --build=$(../config.guess) \
      --disable-multilib         \
      --disable-nls              \
      --disable-libstdcxx-pch    \
      --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR/$LFS install

  rm -v $KPKG_TMP_DIR/$LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
}
