#!/bin/bash

KPKG_SRC_FILE=libwacom-2.12.2.tar.xz
KPKG_SRC_FOLDER=libwacom-2.12.2

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -D tests=disabled
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_pre_install() {
  rm -rf /usr/share/libwacom
  DESTDIR=$KPKG_TMP_DIR ninja install
}
