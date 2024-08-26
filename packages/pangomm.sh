#!/bin/bash

KPKG_SRC_FILE=pangomm-2.46.4.tar.xz
KPKG_SRC_FOLDER=pangomm-2.46.4

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

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
