#!/bin/bash

KPKG_SRC_FILE=libsigc++-2.12.1.tar.xz
KPKG_SRC_FOLDER=libsigc++-2.12.1

k_pre_configure() {
  mkdir bld
  cd    bld
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release ..
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
