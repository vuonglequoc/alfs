#!/bin/bash

KPKG_SRC_FILE=Waybar-0.10.4.tar.gz
KPKG_SRC_FOLDER=Waybar-0.10.4

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release -Dman-pages=disabled ..
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

k_post_install() {
  mkdir -p /home/$NONROOT_USER/.config/waybar/
  cp -r /alfs/defaults/.config/waybar/* /home/$NONROOT_USER/.config/waybar/
}
