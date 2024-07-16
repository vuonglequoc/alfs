#!/bin/bash

KPKG_SRC_FILE=texinfo-7.1.tar.xz
KPKG_SRC_FOLDER=texinfo-7.1

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}
