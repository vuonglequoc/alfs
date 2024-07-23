#!/bin/bash

KPKG_SRC_FILE=libaom-3.9.1.tar.gz
KPKG_SRC_FOLDER=libaom-3.9.1

k_pre_configure() {
  mkdir aom-build
  cd    aom-build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr \
        -D CMAKE_BUILD_TYPE=Release  \
        -D BUILD_SHARED_LIBS=1       \
        -D ENABLE_DOCS=no            \
        -G Ninja ..
}

k_build() {
  ninja
}

k_check() {
  ninja runtests
}

k_install() {
  ninja install
  rm -v /usr/lib/libaom.a
}

k_pre_record() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  rm -v $KPKG_TMP_DIR/usr/lib/libaom.a
}
