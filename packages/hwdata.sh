#!/bin/bash

KPKG_SRC_FILE=hwdata-0.385.tar.gz
KPKG_SRC_FOLDER=hwdata-0.385

k_configure() {
  ./configure --prefix=/usr --disable-blacklist
}

k_check() {
  :
}
