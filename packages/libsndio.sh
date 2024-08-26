#!/bin/bash

KPKG_SRC_FILE=sndio-1.10.0.tar.gz
KPKG_SRC_FOLDER=sndio-1.10.0

k_configure() {
  ./configure --prefix=/usr
}
