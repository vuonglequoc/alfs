#!/bin/bash

KPKG_SRC_FILE=
KPKG_SRC_FOLDER=FiraCode-6.2

k_prepare_source() {
  mkdir -p $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  cd $KPKG_ROOT/sources/$KPKG_SRC_FOLDER
  wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
  unzip Fira_Code_v6.2.zip
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
  mkdir -p /usr/share/fonts/truetype/FiraCode
  mv $KPKG_ROOT/sources/$KPKG_SRC_FOLDER/ttf/*.ttf /usr/share/fonts/truetype/FiraCode/
  fc-cache -f -v
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/usr/share/fonts/truetype/FiraCode
  cp /usr/share/fonts/truetype/FiraCode/*.ttf $KPKG_TMP_DIR/usr/share/fonts/truetype/FiraCode/
}
