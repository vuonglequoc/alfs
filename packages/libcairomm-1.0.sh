#!/bin/bash

KPKG_SRC_FILE=cairomm-1.14.5.tar.xz
KPKG_SRC_FOLDER=cairomm-1.14.5

k_pre_configure() {
  mkdir bld
  cd    bld
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -Dbuild-tests=false \
        -Dboost-shared=true
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
