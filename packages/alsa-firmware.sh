#!/bin/bash

KPKG_SRC_FILE=alsa-firmware-1.2.4.tar.bz2
KPKG_SRC_FOLDER=alsa-firmware-1.2.4

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  :
}
