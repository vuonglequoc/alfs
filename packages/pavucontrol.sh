#!/bin/bash

KPKG_SRC_FILE=pavucontrol-5.0.tar.xz
KPKG_SRC_FOLDER=pavucontrol-5.0

k_configure() {
  ./configure --prefix=/usr --docdir=/usr/share/doc/pavucontrol-5.0
}

k_check() {
  :
}
