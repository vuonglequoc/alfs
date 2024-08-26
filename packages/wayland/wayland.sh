#!/bin/bash

KPKG_SRC_FILE=wayland-1.23.0.tar.xz
KPKG_SRC_FOLDER=wayland-1.23.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -D documentation=false
}

k_build() {
  ninja
}

k_check() {
  env -u XDG_RUNTIME_DIR ninja test
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
