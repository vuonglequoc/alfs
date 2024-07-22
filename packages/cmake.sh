#!/bin/bash

KPKG_SRC_FILE=cmake-3.30.1.tar.gz
KPKG_SRC_FOLDER=cmake-3.30.1

k_pre_configure() {
  sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake
}

k_configure() {
  ./bootstrap --prefix=/usr        \
              --system-libs        \
              --mandir=/share/man  \
              --no-system-jsoncpp  \
              --no-system-cppdap   \
              --no-system-librhash \
              --docdir=/share/doc/cmake-3.30.1
}

k_check() {
  LC_ALL=en_US.UTF-8 bin/ctest -j2 -O cmake-3.30.1-test.log
}
