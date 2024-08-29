#!/bin/bash

KPKG_SRC_FILE=wofi-upstream-1.2.4.tar.gz
KPKG_SRC_FOLDER=wofi-upstream-1.2.4

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
  mkdir -p /home/$NONROOT_USER/.config/wofi/
  cp -r /alfs/defaults/.config/wofi/* /home/$NONROOT_USER/.config/wofi/
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install

  mkdir -p $KPKG_TMP_DIR/home/$NONROOT_USER/.config/wofi/
  cp -r /alfs/defaults/.config/wofi/* $KPKG_TMP_DIR/home/$NONROOT_USER/.config/wofi/
}