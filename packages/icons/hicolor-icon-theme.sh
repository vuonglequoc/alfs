#!/bin/bash

KPKG_SRC_FILE=hicolor-icon-theme-0.18.tar.xz
KPKG_SRC_FOLDER=hicolor-icon-theme-0.18

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
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
