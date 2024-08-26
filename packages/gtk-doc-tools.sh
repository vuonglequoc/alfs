#!/bin/bash

KPKG_SRC_FILE=gtk-doc-1.34.0.tar.gz
KPKG_SRC_FOLDER=gtk-doc-1.34.0

k_pre_configure() {
  mkdir -p build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release
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
