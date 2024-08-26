#!/bin/bash

KPKG_SRC_FILE=mtdev-1.1.7.tar.bz2
KPKG_SRC_FOLDER=mtdev-1.1.7

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  :
}
