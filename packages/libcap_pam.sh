#!/bin/bash

KPKG_SRC_FILE=libcap-2.69.tar.xz
KPKG_SRC_FOLDER=libcap-2.69

k_configure() {
  :
}

k_build() {
  make -C pam_cap
}

k_check() {
  :
}

k_install() {
  install -v -m755 pam_cap/pam_cap.so /usr/lib/security
  install -v -m644 pam_cap/capability.conf /etc/security
}

k_pre_record() {
  install -v -m755 -d $KPKG_TMP_DIR/usr/lib/security
  install -v -m755 -d $KPKG_TMP_DIR/etc/security
  install -v -m755 pam_cap/pam_cap.so $KPKG_TMP_DIR/usr/lib/security
  install -v -m644 pam_cap/capability.conf $KPKG_TMP_DIR/etc/security
}