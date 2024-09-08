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
        --buildtype=release \
        -D debug-gui=false  \
        -D tests=false      \
        -D udev-dir=/usr/lib/udev
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
