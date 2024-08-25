#!/bin/bash

KPKG_SRC_FILE=icu4c-75_1-src.tgz
KPKG_SRC_FOLDER=icu

k_pre_configure() {
  cd source
}

k_configure() {
  ./configure --prefix=/usr
}
