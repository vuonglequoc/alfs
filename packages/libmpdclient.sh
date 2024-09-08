#!/bin/bash

KPKG_SRC_FILE=libmpdclient-2.22.tar.gz
KPKG_SRC_FOLDER=libmpdclient-2.22

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release ..
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
