#!/bin/bash

KPKG_SRC_FILE=cava-0.10.2.tar.gz
KPKG_SRC_FOLDER=cava-0.10.2

k_configure() {
  ./autogen.sh
  ./configure --prefix=/usr
}

k_check() {
  :
}
