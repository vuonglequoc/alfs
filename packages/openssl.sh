#!/bin/bash

KPKG_SRC_FILE=openssl-3.3.1.tar.gz
KPKG_SRC_FOLDER=openssl-3.3.1

k_configure() {
  ./config --prefix=/usr         \
          --openssldir=/etc/ssl \
          --libdir=lib          \
          shared                \
          zlib-dynamic
}

k_check() {
  HARNESS_JOBS=$(nproc) make test
}

k_pre_install() {
  sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
  make DESTDIR=$KPKG_TMP_DIR MANSUFFIX=ssl install

  mv -v $KPKG_TMP_DIR/usr/share/doc/openssl $KPKG_TMP_DIR/usr/share/doc/openssl-3.3.1
  cp -vfr doc/* $KPKG_TMP_DIR/usr/share/doc/openssl-3.3.1
}
