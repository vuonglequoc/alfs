#!/bin/bash

KPKG_SRC_FILE=json-c-0.17.tar.gz
KPKG_SRC_FOLDER=json-c-0.17

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr \
        -D CMAKE_BUILD_TYPE=Release  \
        -D BUILD_STATIC_LIBS=OFF     \
        ..
}

k_build() {
  make
  # doxygen doc/Doxyfile
}

k_check() {
  make test
}

k_post_install() {
  # install -d -vm755 /usr/share/doc/json-c-0.17 &&
  # install -v -m644 doc/html/* /usr/share/doc/json-c-0.17
  :
}