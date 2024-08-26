#!/bin/bash

KPKG_SRC_FILE=fmt-10.2.1.tar.gz
KPKG_SRC_FOLDER=fmt-10.2.1

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr     \
        -D CMAKE_INSTALL_LIBDIR=/usr/lib \
        -D BUILD_SHARED_LIBS=ON          \
        -D FMT_TEST=OFF                  \
        -G Ninja ..
}

k_build() {
  ninja
}

k_check() {
  :
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
