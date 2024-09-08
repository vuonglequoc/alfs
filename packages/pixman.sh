#!/bin/bash

KPKG_SRC_FILE=pixman-0.43.4.tar.gz
KPKG_SRC_FOLDER=pixman-0.43.4

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
