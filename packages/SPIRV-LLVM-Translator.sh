#!/bin/bash

KPKG_SRC_FILE=SPIRV-LLVM-Translator-18.1.3.tar.gz
KPKG_SRC_FOLDER=SPIRV-LLVM-Translator-18.1.3

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr                   \
        -D CMAKE_BUILD_TYPE=Release                    \
        -D BUILD_SHARED_LIBS=ON                        \
        -D CMAKE_SKIP_INSTALL_RPATH=ON                 \
        -D LLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR=/usr \
        -G Ninja ..
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
