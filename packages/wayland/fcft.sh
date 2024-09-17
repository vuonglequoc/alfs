#!/bin/bash

KPKG_SRC_FILE=fcft-3.1.8.tar.gz
KPKG_SRC_FOLDER=fcft-3.1.8

k_pre_configure() {
  patch -Np1 -i /alfs/patches/fcft-3.1.8-3rd-party_nanosvg_uninitialized_fixes-1.patch

  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -Ddocs=disabled
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
