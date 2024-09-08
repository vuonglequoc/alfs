#!/bin/bash

KPKG_SRC_FILE=libxkbcommon-1.7.0.tar.xz
KPKG_SRC_FOLDER=libxkbcommon-1.7.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..             \
        --prefix=/usr        \
        --buildtype=release  \
        -D enable-docs=false
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
