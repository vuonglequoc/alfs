#!/bin/bash

KPKG_SRC_FILE=yasm-1.3.0.tar.gz
KPKG_SRC_FOLDER=yasm-1.3.0

k_pre_configure() {
  sed -i 's#) ytasm.*#)#' Makefile.in
}

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  make -j1 check
}
