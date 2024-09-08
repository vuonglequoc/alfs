#!/bin/bash

KPKG_SRC_FILE=
KPKG_SRC_FOLDER=

k_prepare_source() {
  :
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
  mkdir -p $KPKG_TMP_DIR/usr/share/fonts/opentype/FontAwesome
  cd $KPKG_TMP_DIR/usr/share/fonts/opentype/FontAwesome
  wget https://github.com/h5p/font-awesome/raw/master/FontAwesome.otf
}

k_post_install() {
  fc-cache -f -v
}

k_build_clean() {
  :
}
