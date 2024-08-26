#!/bin/bash

KPKG_SRC_FILE=cairo-1.18.0.tar.xz
KPKG_SRC_FOLDER=cairo-1.18.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release -Dxlib-xcb=enabled ..
}

k_build() {
  ninja
}

k_check() {
  :
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
