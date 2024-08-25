#!/bin/bash

KPKG_SRC_FILE=gnutls-3.8.6.tar.xz
KPKG_SRC_FOLDER=gnutls-3.8.6

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/gnutls-3.8.6 \
              --with-default-trust-store-pkcs11="pkcs11:"
}
