#!/bin/bash

KPKG_SRC_FILE=harfbuzz-9.0.0.tar.xz
KPKG_SRC_FOLDER=harfbuzz-9.0.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..             \
        --prefix=/usr        \
        --buildtype=release  \
        -D graphite2=enabled
}

k_build() {
  ninja
}

k_check() {
  ninja check
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
