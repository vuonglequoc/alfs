#!/bin/bash

SRC_FILE=popt-1.19.tar.gz
SRC_FOLDER=popt-1.19

k_configure() {
  ./configure --prefix=/usr \
              --disable-static
}
