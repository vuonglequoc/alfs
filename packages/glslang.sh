#!/bin/bash

KPKG_SRC_FILE=glslang-14.3.0.tar.gz
KPKG_SRC_FOLDER=glslang-14.3.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr     \
        -D CMAKE_BUILD_TYPE=Release      \
        -D ALLOW_EXTERNAL_SPIRV_TOOLS=ON \
        -D BUILD_SHARED_LIBS=ON          \
        -D GLSLANG_TESTS=ON              \
        -G Ninja ..
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
