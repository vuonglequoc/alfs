#!/bin/bash

KPKG_SRC_FILE=brotli-1.1.0.tar.gz
KPKG_SRC_FOLDER=brotli-1.1.0

k_pre_configure() {
  mkdir build
  cd    build
}

k_configure() {
  cmake -D CMAKE_INSTALL_PREFIX=/usr \
        -D CMAKE_BUILD_TYPE=Release  \
        ..
}

k_check() {
  make test
}

k_post_install() {
  cd ..
  sed "/c\/.*\.[ch]'/d;\
      /include_dirs=\[/\
      i libraries=['brotlicommon','brotlidec','brotlienc']," \
      -i setup.py &&
  pip3 wheel -w dist --no-build-isolation --no-deps --no-cache-dir $PWD

  pip3 install --no-index --find-links=dist --no-cache-dir --no-user Brotli
}
