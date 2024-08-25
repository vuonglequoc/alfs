#!/bin/bash

KPKG_SRC_FILE=which-2.21.tar.gz
KPKG_SRC_FOLDER=which-2.21

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}
