#!/bin/bash

KPKG_SRC_FILE=wlroots-0.17.4.tar.gz
KPKG_SRC_FOLDER=wlroots-0.17.4

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
