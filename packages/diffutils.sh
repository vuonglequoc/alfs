#!/bin/bash

KPKG_SRC_FILE=diffutils-3.10.tar.xz
KPKG_SRC_FOLDER=diffutils-3.10

k_configure() {
  ./configure --prefix=/usr
}
