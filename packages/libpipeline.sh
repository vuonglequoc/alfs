#!/bin/bash

KPKG_SRC_FILE=libpipeline-1.5.7.tar.gz
KPKG_SRC_FOLDER=libpipeline-1.5.7

k_configure() {
  ./configure --prefix=/usr
}
