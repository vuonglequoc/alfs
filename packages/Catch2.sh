#!/bin/bash

KPKG_SRC_FILE=Catch2-3.7.0.tar.gz
KPKG_SRC_FOLDER=Catch2-3.7.0

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
  :
}

k_install() {
  ninja install
}

k_post_install() {
  sudo cp ../src/catch2/internal/catch_config_prefix_messages.hpp /usr/include/catch2/internal/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  sudo cp ../src/catch2/internal/catch_config_prefix_messages.hpp $KPKG_TMP_DIR/usr/include/catch2/internal/
}
