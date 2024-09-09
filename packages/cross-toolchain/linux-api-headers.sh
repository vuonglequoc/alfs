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
  :
}

k_install() {
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LFS/usr
}
