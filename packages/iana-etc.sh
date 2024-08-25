#!/bin/bash

KPKG_SRC_FILE=iana-etc-20240125.tar.gz
KPKG_SRC_FOLDER=iana-etc-20240125

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_install() {
  cp services protocols /etc
}

k_pre_record() {
  mkdir -p $KPKG_TMP_DIR/etc
  cp services protocols $KPKG_TMP_DIR/etc
}
