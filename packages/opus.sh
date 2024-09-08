#!/bin/bash

KPKG_SRC_FILE=opus-1.5.2.tar.gz
KPKG_SRC_FOLDER=opus-1.5.2

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr        \
              --buildtype=release  \
              -Ddocdir=/usr/share/doc/opus-1.5.2
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
