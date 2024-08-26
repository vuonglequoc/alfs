#!/bin/bash

KPKG_SRC_FILE=libdisplay-info-0.2.0.tar.xz
KPKG_SRC_FOLDER=libdisplay-info-0.2.0

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

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
