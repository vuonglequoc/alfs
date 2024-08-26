#!/bin/bash

KPKG_SRC_FILE=fftw-3.3.10.tar.gz
KPKG_SRC_FOLDER=fftw-3.3.10

k_configure() {
  ./configure --enable-shared
}

k_build() {
  make CFLAGS=-fPIC
}

k_check() {
  :
}

k_post_install() {
  /sbin/ldconfig
}
