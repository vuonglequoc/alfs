#!/bin/bash

KPKG_SRC_FILE=efibootmgr-18.tar.gz
KPKG_SRC_FOLDER=efibootmgr-18

k_configure() {
  :
}

k_build() {
  make EFIDIR=LFS EFI_LOADER=grubx64.efi
}

k_check() {
  :
}

k_install() {
  make install EFIDIR=LFS
}

k_pre_record() {
  make DESTDIR=$KPKG_TMP_DIR install EFIDIR=LFS
}
