#!/bin/bash

KPKG_SRC_FILE=itstool-2.0.7.tar.bz2
KPKG_SRC_FOLDER=itstool-2.0.7

k_pre_configure() {
  sed -i 's/re.sub(/re.sub(r/'         itstool.in
  sed -i 's/re.compile(/re.compile(r/' itstool.in
}

k_configure() {
  PYTHON=/usr/bin/python3 ./configure --prefix=/usr
}

k_check() {
  :
}
