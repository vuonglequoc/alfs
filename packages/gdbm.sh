#!/bin/bash

KPKG_SRC_FILE=gdbm-1.24.tar.gz
KPKG_SRC_FOLDER=gdbm-1.24

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --enable-libgdbm-compat
}
