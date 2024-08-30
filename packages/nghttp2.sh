#!/bin/bash

KPKG_SRC_FILE=nghttp2-1.62.1.tar.xz
KPKG_SRC_FOLDER=nghttp2-1.62.1

k_configure() {
  ./configure --prefix=/usr     \
              --disable-static  \
              --enable-lib-only \
              --docdir=/usr/share/doc/nghttp2-1.62.1
}

k_post_install() {
  /sbin/ldconfig
}
