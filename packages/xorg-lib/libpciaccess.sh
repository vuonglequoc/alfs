#!/bin/bash

KPKG_SRC_FILE=libpciaccess-0.18.1.tar.xz
KPKG_SRC_FOLDER=libpciaccess-0.18.1
XORG_PREFIX=/usr

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup .. \
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
