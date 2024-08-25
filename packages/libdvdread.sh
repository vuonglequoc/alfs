#!/bin/bash

KPKG_SRC_FILE=libdvdread-6.1.3.tar.bz2
KPKG_SRC_FOLDER=libdvdread-6.1.3

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/libdvdread-6.1.3
}

k_check() {
  :
}
