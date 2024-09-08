#!/bin/bash

KPKG_SRC_FILE=libepoxy-1.5.10.tar.xz
KPKG_SRC_FOLDER=libepoxy-1.5.10

k_pre_configure() {
  mkdir build
  cd    build
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
