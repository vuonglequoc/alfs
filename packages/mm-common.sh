#!/bin/bash

KPKG_SRC_FILE=mm-common-1.0.6.tar.gz
KPKG_SRC_FOLDER=mm-common-1.0.6

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -Duse-network=true
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
