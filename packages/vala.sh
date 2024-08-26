#!/bin/bash

KPKG_SRC_FILE=vala-0.56.17.tar.xz
KPKG_SRC_FOLDER=vala-0.56.17

k_configure() {
  ./configure --prefix=/usr --disable-valadoc
}
