#!/bin/bash

KPKG_SRC_FILE=mpv-0.38.0.tar.gz
KPKG_SRC_FOLDER=mpv-0.38.0

k_pre_configure() {
  sed -i 's/AV_OPT_TYPE_CHANNEL_LAYOUT/AV_OPT_TYPE_CHLAYOUT/' filters/f_lavfi.c

  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr       \
              --buildtype=release \
              -Dx11=disabled      \
              -Ddvdnav=enabled    \
              -Dcdda=enabled      \
              -Dsdl2=enabled      \
              ..
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

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
