#!/bin/bash

KPKG_SRC_FILE=tllist-1.1.0.tar.gz
KPKG_SRC_FOLDER=tllist-1.1.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release
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
