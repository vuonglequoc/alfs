#!/bin/bash

KPKG_SRC_FILE=libpsl-0.21.5.tar.gz
KPKG_SRC_FOLDER=libpsl-0.21.5

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release
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
