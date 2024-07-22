#!/bin/bash

KPKG_SRC_FILE=libksba-1.6.7.tar.bz2
KPKG_SRC_FOLDER=libksba-1.6.7

k_configure() {
  ./configure --prefix=/usr
}
