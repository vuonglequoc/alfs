#!/bin/bash

KPKG_SRC_FILE=xkeyboard-config-2.42.tar.xz
KPKG_SRC_FOLDER=xkeyboard-config-2.42
XORG_PREFIX=/usr

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=$XORG_PREFIX \
        --buildtype=release
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
