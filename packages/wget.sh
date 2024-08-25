#!/bin/bash

KPKG_SRC_FILE=wget-1.24.5.tar.gz
KPKG_SRC_FOLDER=wget-1.24.5

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --with-ssl=openssl
}
