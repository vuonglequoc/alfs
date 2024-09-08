#!/bin/bash

KPKG_SRC_FILE=adwaita-icon-theme-46.2.tar.xz
KPKG_SRC_FOLDER=adwaita-icon-theme-46.2

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  meson setup --prefix=/usr ..
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  rm -rf /usr/share/icons/Adwaita/
  DESTDIR=$KPKG_TMP_DIR ninja install
}
