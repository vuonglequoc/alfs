#!/bin/bash

KPKG_SRC_FILE=tiff-4.6.0.tar.gz
KPKG_SRC_FOLDER=tiff-4.6.0

k_pre_configure() {
  mkdir libtiff-build
  cd    libtiff-build
}

k_configure() {
  cmake -D CMAKE_INSTALL_DOCDIR=/usr/share/doc/libtiff-4.6.0 \
        -D CMAKE_INSTALL_PREFIX=/usr -G Ninja ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
