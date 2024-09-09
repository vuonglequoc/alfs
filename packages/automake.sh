#!/bin/bash

KPKG_SRC_FILE=automake-1.17.tar.xz
KPKG_SRC_FOLDER=automake-1.17

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/automake-1.17
}

k_check() {
  make -j$(($(nproc)>4?$(nproc):4)) check
}
