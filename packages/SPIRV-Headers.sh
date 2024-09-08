#!/bin/bash

KPKG_SRC_FILE=SPIRV-Headers-1.3.290.0.tar.gz
KPKG_SRC_FOLDER=SPIRV-Headers-vulkan-sdk-1.3.290.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr -G Ninja ..
}

k_build() {
  ninja
}

k_check() {
  :
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
