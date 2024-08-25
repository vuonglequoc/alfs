#!/bin/bash

KPKG_SRC_FILE=Vulkan-Headers-1.3.290.tar.gz
KPKG_SRC_FOLDER=Vulkan-Headers-1.3.290

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
  ninja test
}

k_install() {
  ninja install
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
}
