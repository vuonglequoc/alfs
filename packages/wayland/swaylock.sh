#!/bin/bash

KPKG_SRC_FILE=swaylock-1.7.2.tar.gz
KPKG_SRC_FOLDER=swaylock-1.7.2

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup .. \
        --prefix=/usr \
        --buildtype=release
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_install() {
  ninja install
}

k_post_install() {
  mkdir -p /home/user/.config/swaylock/
  cp -r /alfs/defaults/.config/swaylock/* /home/user/.config/swaylock/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
