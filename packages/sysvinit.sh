#!/bin/bash

KPKG_SRC_FILE=sysvinit-3.08.tar.xz
KPKG_SRC_FOLDER=sysvinit-3.08

k_pre_configure() {
  patch -Np1 -i ../sysvinit-3.08-consolidated-1.patch
}

k_configure() {
  :
}

k_check() {
  :
}
