#!/bin/bash

KPKG_SRC_FILE=psmisc-23.7.tar.xz
KPKG_SRC_FOLDER=psmisc-23.7

k_configure() {
  ./configure --prefix=/usr
}
