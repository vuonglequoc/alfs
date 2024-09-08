#!/bin/bash

KPKG_SRC_FILE=spdlog-1.14.1.tar.gz
KPKG_SRC_FOLDER=spdlog-1.14.1

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  export CFLAGS+=" ${CPPFLAGS}"
  export CXXFLAGS+=" ${CPPFLAGS}"
  # FIXME: Stop -DSPDLOG_BUILD_TESTS=ON from downloading bundled catch2
  cmake -DSPDLOG_BUILD_BENCH=OFF \
              -DSPDLOG_FMT_EXTERNAL=ON \
              -DSPDLOG_BUILD_SHARED=ON \
              -DCMAKE_BUILD_TYPE=None \
              -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_INSTALL_LIBDIR=lib \
              -Wno-dev ..
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  install -Dm644 ../LICENSE -t $KPKG_TMP_DIR/usr/share/licenses/spdlog/
}
