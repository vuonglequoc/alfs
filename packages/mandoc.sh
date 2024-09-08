#!/bin/bash

KPKG_SRC_FILE=mandoc-1.14.6.tar.gz
KPKG_SRC_FOLDER=mandoc-1.14.6

k_build() {
  make mandoc
  make regress
}

k_check() {
  :
}

k_pre_install() {
  mkdir -p $KPKG_TMP_DIR/usr/bin
  mkdir -p $KPKG_TMP_DIR/usr/share/man/man1
  install -vm755 mandoc   $KPKG_TMP_DIR/usr/bin
  install -vm644 mandoc.1 $KPKG_TMP_DIR/usr/share/man/man1
}
