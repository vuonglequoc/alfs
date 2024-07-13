#!/bin/bash

SRC_FILE=linux-6.7.4.tar.xz
SRC_FOLDER=linux-6.7.4

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

k_install() {
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LFS/usr
}
