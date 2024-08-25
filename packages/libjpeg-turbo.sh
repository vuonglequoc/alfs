#!/bin/bash

KPKG_SRC_FILE=libjpeg-turbo-3.0.3.tar.gz
KPKG_SRC_FOLDER=libjpeg-turbo-3.0.3

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -DCMAKE_INSTALL_PREFIX=/usr        \
        -DCMAKE_BUILD_TYPE=RELEASE         \
        -DENABLE_STATIC=FALSE              \
        -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib \
        -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/libjpeg-turbo-3.0.3 \
        ..
}

k_check() {
  make test
}
