#!/bin/bash

KPKG_SRC_FILE=libvpx-1.14.1.tar.gz
KPKG_SRC_FOLDER=libvpx-1.14.1

k_pre_configure() {
  sed -i 's/cp -p/cp/' build/make/Makefile

  mkdir libvpx-build
  cd    libvpx-build
}

k_configure() {
  ../configure --prefix=/usr    \
               --enable-shared  \
               --disable-static
}

k_check() {
  LD_LIBRARY_PATH=. make test
}
