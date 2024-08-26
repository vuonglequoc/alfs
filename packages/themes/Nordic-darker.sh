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

k_install() {
  mkdir -p /usr/share/themes
  mv $KPKG_SRC_FOLDER /usr/share/themes/Nordic
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/usr/share/themes/Nordic
  cp /usr/share/themes/Nordic/* $KPKG_TMP_DIR/usr/share/themes/Nordic/
}
