#!/bin/bash

KPKG_SRC_FILE=libwebp-1.4.0.tar.gz
KPKG_SRC_FOLDER=libwebp-1.4.0

k_configure() {
  ./configure --prefix=/usr           \
              --enable-libwebpmux     \
              --enable-libwebpdemux   \
              --enable-libwebpdecoder \
              --enable-libwebpextras  \
              --enable-swap-16bit-csp \
              --disable-static
}

k_check() {
  :
}
