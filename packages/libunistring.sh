#!/bin/bash

KPKG_SRC_FILE=libunistring-1.2.tar.xz
KPKG_SRC_FOLDER=libunistring-1.2

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/libunistring-1.2
}
