#!/bin/bash

KPKG_SRC_FILE=m4-1.4.19.tar.xz
KPKG_SRC_FOLDER=m4-1.4.19

k_configure() {
  ./configure --prefix=/usr
}
