#!/bin/bash

KPKG_SRC_FILE=libusb-1.0.27.tar.bz2
KPKG_SRC_FOLDER=libusb-1.0.27

k_configure() {
  ./configure --prefix=/usr --disable-static
}
