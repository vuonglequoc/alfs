#!/bin/bash

KPKG_SRC_FILE=glibmm-2.66.7.tar.xz
KPKG_SRC_FOLDER=glibmm-2.66.7

k_pre_configure() {
  mkdir bld
  cd    bld
}

k_configure() {
  meson setup --prefix=/usr --buildtype=release ..
}

k_build() {
  ninja
}

k_check() {
  ninja test
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}