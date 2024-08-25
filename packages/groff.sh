#!/bin/bash

KPKG_SRC_FILE=groff-1.23.0.tar.gz
KPKG_SRC_FOLDER=groff-1.23.0

k_configure() {
  PAGE=A4 ./configure --prefix=/usr
}
