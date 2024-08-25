#!/bin/bash

KPKG_SRC_FILE=patch-2.7.6.tar.xz
KPKG_SRC_FOLDER=patch-2.7.6

k_configure() {
  ./configure --prefix=/usr
}
