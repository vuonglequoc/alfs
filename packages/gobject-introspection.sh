#!/bin/bash

KPKG_SRC_FILE=gobject-introspection-1.81.2.tar.xz
KPKG_SRC_FOLDER=gobject-introspection-1.81.2

k_pre_configure() {
  mkdir gi-build
  cd    gi-build
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

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
