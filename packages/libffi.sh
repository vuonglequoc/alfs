#!/bin/bash

KPKG_SRC_FILE=libffi-3.4.4.tar.gz
KPKG_SRC_FOLDER=libffi-3.4.4

k_configure() {
  ./configure --prefix=/usr    \
              --disable-static \
              --with-gcc-arch=native
}
