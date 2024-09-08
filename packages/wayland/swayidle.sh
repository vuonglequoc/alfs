#!/bin/bash

KPKG_SRC_FILE=swayidle-1.8.0.tar.gz
KPKG_SRC_FOLDER=swayidle-1.8.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup .. \
        --prefix=/usr \
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
