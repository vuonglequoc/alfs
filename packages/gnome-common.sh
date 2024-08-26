#!/bin/bash

KPKG_SRC_FILE=gnome-common-3.18.0.tar.gz
KPKG_SRC_FOLDER=gnome-common-3.18.0

k_configure() {
  ./autogen.sh
  ./configure --prefix=/usr
}
