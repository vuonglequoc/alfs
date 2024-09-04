#!/bin/bash

KPKG_SRC_FILE=bison-3.8.2.tar.xz
KPKG_SRC_FOLDER=bison-3.8.2

k_configure() {
  ./configure --prefix=/usr \
              --docdir=/usr/share/doc/bison-3.8.2
}

k_check() {
  :
}
