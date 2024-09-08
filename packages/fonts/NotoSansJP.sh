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
  mkdir -p $KPKG_TMP_DIR/usr/share/fonts/truetype/NotoSansJP
  cd $KPKG_TMP_DIR/usr/share/fonts/truetype/NotoSansJP
  wget https://github.com/google/fonts/raw/main/ofl/notosansjp/NotoSansJP%5Bwght%5D.ttf
}

k_post_install() {
  fc-cache -f -v
}

k_build_clean() {
  :
}
