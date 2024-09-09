#!/bin/bash

KPKG_SRC_FILE=xz-5.6.2.tar.xz
KPKG_SRC_FOLDER=xz-5.6.2

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/xz-5.6.2
}
