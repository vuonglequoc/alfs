#!/bin/bash

KPKG_SRC_FILE=libxcrypt-4.4.36.tar.xz
KPKG_SRC_FOLDER=libxcrypt-4.4.36

k_configure() {
  ./configure --prefix=/usr                \
              --enable-hashes=strong,glibc \
              --enable-obsolete-api=no     \
              --disable-static             \
              --disable-failure-tokens
}
