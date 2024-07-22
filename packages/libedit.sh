#!/bin/bash

KPKG_SRC_FILE=libedit-20240517-3.1.tar.gz
KPKG_SRC_FOLDER=libedit-20240517-3.1

k_configure() {
  ./configure --prefix=/usr --disable-static
}
