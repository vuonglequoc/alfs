#!/bin/bash

KPKG_SRC_FILE=c-ares-1.33.0.tar.gz
KPKG_SRC_FOLDER=c-ares-1.33.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake  -D CMAKE_INSTALL_PREFIX=/usr ..
}

k_check() {
  :
}
