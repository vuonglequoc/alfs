#!/bin/bash

KPKG_SRC_FILE=Nordic-darker-standard-buttons-v40.tar.xz
KPKG_SRC_FOLDER=Nordic-darker-standard-buttons-v40

k_prepare_source() {
  cd $KPKG_ROOT/sources
  wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic-darker-standard-buttons-v40.tar.xz
  tar xvf $KPKG_SRC_FILE
}

k_pre_configure() {
  :
}

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_pre_install() {
  mkdir -p $KPKG_TMP_DIR/usr/share/themes
  mv $KPKG_SRC_FOLDER $KPKG_TMP_DIR/usr/share/themes/Nordic
}

k_build_clean() {
  :
}
