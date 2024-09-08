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

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}

k_post_install() {
  mkdir -p /home/$NONROOT_USER/.config/wofi/
  cp -r /alfs/defaults/.config/wofi/* /home/$NONROOT_USER/.config/wofi/
}
