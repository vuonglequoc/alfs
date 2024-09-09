#!/bin/bash

KPKG_SRC_FILE=libcap-2.70.tar.xz
KPKG_SRC_FOLDER=libcap-2.70

k_configure() {
  :
}

k_build() {
  make -C pam_cap
}

k_check() {
  :
}

k_pre_install() {
  install -v -m755 -d $KPKG_TMP_DIR/usr/lib/security
  install -v -m755 -d $KPKG_TMP_DIR/etc/security
  install -v -m755 pam_cap/pam_cap.so $KPKG_TMP_DIR/usr/lib/security
  install -v -m644 pam_cap/capability.conf $KPKG_TMP_DIR/etc/security
}
