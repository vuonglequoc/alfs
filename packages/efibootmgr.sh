#!/bin/bash

SRC_FILE=efibootmgr-18.tar.gz
SRC_FOLDER=efibootmgr-18

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
