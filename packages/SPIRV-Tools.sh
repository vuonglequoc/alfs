#!/bin/bash

KPKG_SRC_FILE=SPIRV-Tools-1.3.290.0.tar.gz
KPKG_SRC_FOLDER=SPIRV-Tools-vulkan-sdk-1.3.290.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr     \
        -D CMAKE_BUILD_TYPE=Release      \
        -D SPIRV_WERROR=OFF              \
        -D BUILD_SHARED_LIBS=ON          \
        -D SPIRV_TOOLS_BUILD_STATIC=OFF  \
        -D SPIRV-Headers_SOURCE_DIR=/usr \
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
