#!/bin/bash

KPKG_SRC_FILE=linux-6.10.7.tar.xz
KPKG_SRC_FOLDER=linux-6.10.7

k_pre_configure() {
  make mrproper
}

k_configure() {
  :
}

k_build() {
  make headers
}

k_check() {
  :
}

k_pre_install() {
  find usr/include -type f ! -name '*.h' -delete
  mkdir -p $KPKG_TMP_DIR/$LFS/usr
  cp -rv usr/include $KPKG_TMP_DIR/$LFS/usr
}
