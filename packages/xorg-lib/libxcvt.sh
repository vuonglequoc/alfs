#!/bin/bash

KPKG_SRC_FILE=libxcvt-0.1.2.tar.xz
KPKG_SRC_FOLDER=libxcvt-0.1.2
XORG_PREFIX=/usr

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..              \
        --prefix=$XORG_PREFIX \
        --buildtype=release
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

k_post_install() {
  /sbin/ldconfig
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
