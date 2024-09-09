#!/bin/bash

KPKG_SRC_FILE=gcc-14.2.0.tar.xz
KPKG_SRC_FOLDER=gcc-14.2.0

k_pre_configure() {
  mkdir -v build
  cd       build
}

k_configure() {
  ../libstdc++-v3/configure      \
      --host=$LFS_TGT            \
      --build=$(../config.guess) \
      --prefix=/usr              \
      --disable-multilib         \
      --disable-nls              \
      --disable-libstdcxx-pch    \
      --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0
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
  rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
}
