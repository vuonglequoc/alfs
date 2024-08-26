#!/bin/bash

KPKG_SRC_FILE=libinput-1.26.1.tar.gz
KPKG_SRC_FOLDER=libinput-1.26.1

k_pre_configure() {
  mkdir build
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
  :
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
