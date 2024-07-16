#!/bin/bash

KPKG_SRC_FILE=gdbm-1.23.tar.gz
KPKG_SRC_FOLDER=gdbm-1.23

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --enable-libgdbm-compat
}
