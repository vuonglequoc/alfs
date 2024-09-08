#!/bin/bash

KPKG_SRC_FILE=upower-v1.90.4.tar.bz2
KPKG_SRC_FOLDER=upower-v1.90.4

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup ..                   \
        --prefix=/usr              \
        --buildtype=release        \
        -D gtk-doc=false           \
        -D man=false               \
        -D systemdsystemunitdir=no \
        -D udevrulesdir=/usr/lib/udev/rules.d
}

k_build() {
  ninja
}

k_check() {
  LC_ALL=C ninja test
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
