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

k_install() {
  mkdir -p /usr/share/fonts/opentype/FontAwesome
  cd /usr/share/fonts/opentype/FontAwesome
  wget https://github.com/h5p/font-awesome/raw/master/FontAwesome.otf
  fc-cache -f -v
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/usr/share/fonts/opentype/FontAwesome
  cp /usr/share/fonts/opentype/FontAwesome/FontAwesome.otf $KPKG_TMP_DIR/usr/share/fonts/opentype/FontAwesome/FontAwesome.otf
}

k_build_clean() {
  :
}
