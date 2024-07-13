#!/bin/bash

SRC_FILE=man-pages-6.06.tar.xz
SRC_FOLDER=man-pages-6.06

k_pre_configure() {
  rm -v man3/crypt*
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
  make prefix=/usr install
}
