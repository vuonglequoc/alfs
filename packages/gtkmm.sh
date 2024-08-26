#!/bin/bash

KPKG_SRC_FILE=gtkmm-3.24.9.tar.xz
KPKG_SRC_FOLDER=gtkmm-3.24.9

k_pre_configure() {
  mkdir gtkmm3-build
  cd    gtkmm3-build
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
