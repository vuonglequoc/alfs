#!/bin/bash

KPKG_SRC_FILE=libass-0.17.3.tar.xz
KPKG_SRC_FOLDER=libass-0.17.3

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  :
}
