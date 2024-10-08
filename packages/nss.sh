#!/bin/bash

KPKG_SRC_FILE=nss-3.103.tar.gz
KPKG_SRC_FOLDER=nss-3.103

k_pre_configure() {
  patch -Np1 -i ../nss-3.103-standalone-1.patch

  cd nss
}

k_configure() {
  :
}

k_build() {
  make BUILD_OPT=1                                \
    NSPR_INCLUDE_DIR=/usr/include/nspr            \
    USE_SYSTEM_ZLIB=1                             \
    ZLIB_LIBS=-lz                                 \
    NSS_ENABLE_WERROR=0                           \
    $([ $(uname -m) = x86_64 ] && echo USE_64=1)  \
    $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1)
}

k_check() {
  cd tests
  HOST=localhost DOMSUF=localdomain ./all.sh
  cd ../
}

k_pre_install() {
  cd ../dist

  mkdir -pv $KPKG_TMP_DIR/usr/lib
  install -v -m755 Linux*/lib/*.so              $KPKG_TMP_DIR/usr/lib
  install -v -m644 Linux*/lib/{*.chk,libcrmf.a} $KPKG_TMP_DIR/usr/lib

  install -v -m755 -d                           $KPKG_TMP_DIR/usr/include/nss
  cp -v -RL {public,private}/nss/*              $KPKG_TMP_DIR/usr/include/nss

  mkdir -pv $KPKG_TMP_DIR/usr/bin
  install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} $KPKG_TMP_DIR/usr/bin

  mkdir -pv $KPKG_TMP_DIR/usr/lib/pkgconfig
  install -v -m644 Linux*/lib/pkgconfig/nss.pc  $KPKG_TMP_DIR/usr/lib/pkgconfig
}
