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
  mkdir -p /usr/share/fonts/truetype/Ubuntu
  cd /usr/share/fonts/truetype/Ubuntu
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-Bold.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-BoldItalic.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-Italic.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-Light.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-LightItalic.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-Medium.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-MediumItalic.ttf
  wget https://github.com/google/fonts/blob/main/ufl/ubuntu/Ubuntu-Regular.ttf
  fc-cache -f -v
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/usr/share/fonts/truetype/Ubuntu
  cp /usr/share/fonts/truetype/Ubuntu/*.ttf $KPKG_TMP_DIR/usr/share/fonts/truetype/Ubuntu/
}

k_build_clean() {
  :
}
