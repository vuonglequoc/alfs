#!/bin/bash

KPKG_SRC_FILE=libdrm-2.4.122.tar.xz
KPKG_SRC_FOLDER=libdrm-2.4.122

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -D udev=true        \
        -D valgrind=disabled
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
