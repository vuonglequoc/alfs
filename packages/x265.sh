#!/bin/bash

KPKG_SRC_FILE=x265-20240216.tar.xz
KPKG_SRC_FOLDER=x265-20240216

k_pre_configure() {
  mkdir bld
  cd    bld
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr \
        -D GIT_ARCHETYPE=1           \
        -W no-dev ../source
}

k_check() {
  :
}

k_install() {
  make install
  rm -vf /usr/lib/libx265.a
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install
  rm -vf $KPKG_TMP_DIR/usr/lib/libx265.a
}
