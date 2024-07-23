#!/bin/bash

KPKG_SRC_FILE=fdk-aac-2.0.3.tar.gz
KPKG_SRC_FOLDER=fdk-aac-2.0.3

k_configure() {
  ./configure --prefix=/usr --disable-static
}

k_check() {
  :
}
