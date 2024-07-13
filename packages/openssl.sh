#!/bin/bash

SRC_FILE=openssl-3.2.1.tar.gz
SRC_FOLDER=openssl-3.2.1

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

k_install() {
  sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
  make MANSUFFIX=ssl install
}

k_post_install() {
  mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.2.1
  cp -vfr doc/* /usr/share/doc/openssl-3.2.1
}
