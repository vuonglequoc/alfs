#!/bin/bash

KPKG_SRC_FILE=libogg-1.3.5.tar.xz
KPKG_SRC_FOLDER=libogg-1.3.5

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/libogg-1.3.5
}
