#!/bin/bash

SRC_FILE=mandoc-1.14.6.tar.gz
SRC_FOLDER=mandoc-1.14.6

k_build() {
  make mandoc
  make regress
}

k_check() {
  :
}

k_install() {
  install -vm755 mandoc   /usr/bin
  install -vm644 mandoc.1 /usr/share/man/man1
}

k_pre_record() {
  mkdir -p $KPKG_DEST_DIR/usr/bin
  mkdir -p $KPKG_DEST_DIR/usr/share/man/man1
  install -vm755 mandoc   $KPKG_DEST_DIR/usr/bin
  install -vm644 mandoc.1 $KPKG_DEST_DIR/usr/share/man/man1
}
