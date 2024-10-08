#!/bin/bash

KPKG_SRC_FILE=libevdev-1.13.2.tar.xz
KPKG_SRC_FOLDER=libevdev-1.13.2

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup .. \
        --prefix=/usr \
        --buildtype=release \
        -Ddocumentation=disabled
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
