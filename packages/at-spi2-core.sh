#!/bin/bash

KPKG_SRC_FILE=at-spi2-core-2.52.0.tar.xz
KPKG_SRC_FOLDER=at-spi2-core-2.52.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..            \
        --prefix=/usr       \
        --buildtype=release \
        -D systemd_user_dir=/tmp
}

k_build() {
  ninja
}

k_check() {
  dbus-run-session ninja test
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  rm $KPKG_TMP_DIR/tmp/at-spi-dbus-bus.service
}
