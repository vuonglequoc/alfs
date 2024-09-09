#!/bin/bash

KPKG_SRC_FILE=libtirpc-1.3.5.tar.bz2
KPKG_SRC_FOLDER=libtirpc-1.3.5

k_configure() {
  ./configure --prefix=/usr     \
              --sysconfdir=/etc \
              --disable-static
}

k_check() {
  :
}
