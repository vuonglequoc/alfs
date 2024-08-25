#!/bin/bash

KPKG_SRC_FILE=xz-5.4.6.tar.xz
KPKG_SRC_FOLDER=xz-5.4.6

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/xz-5.4.6
}
