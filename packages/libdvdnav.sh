#!/bin/bash

KPKG_SRC_FILE=libdvdnav-6.1.1.tar.bz2
KPKG_SRC_FOLDER=libdvdnav-6.1.1

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --docdir=/usr/share/doc/libdvdnav-6.1.1
}

k_check() {
  :
}
