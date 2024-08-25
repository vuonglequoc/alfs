#!/bin/bash

KPKG_SRC_FILE=alsa-plugins-1.2.12.tar.bz2
KPKG_SRC_FOLDER=alsa-plugins-1.2.12

k_configure() {
  ./configure --sysconfdir=/etc
}

k_check() {
  :
}
