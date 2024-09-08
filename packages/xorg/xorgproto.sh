#!/bin/bash

KPKG_SRC_FILE=xorgproto-2024.1.tar.xz
KPKG_SRC_FOLDER=xorgproto-2024.1
XORG_PREFIX=/usr

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=$XORG_PREFIX
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mv -v $KPKG_TMP_DIR/usr/share/doc/xorgproto{,-2024.1}
}
