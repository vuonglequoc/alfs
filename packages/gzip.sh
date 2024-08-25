#!/bin/bash

KPKG_SRC_FILE=gzip-1.13.tar.xz
KPKG_SRC_FOLDER=gzip-1.13

k_configure() {
  ./configure --prefix=/usr
}
