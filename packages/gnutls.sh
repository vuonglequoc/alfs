#!/bin/bash

KPKG_SRC_FILE=gnutls-3.8.7.1.tar.xz
KPKG_SRC_FOLDER=gnutls-3.8.7.1

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/gnutls-3.8.7.1 \
              --with-default-trust-store-pkcs11="pkcs11:" \
              --enable-openssl-compatibility
}

k_check() {
  sed '/ocsp-must-staple-connection/d' -i tests/Makefile
  make check
}
