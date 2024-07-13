#!/bin/bash

SRC_FILE=groff-1.23.0.tar.gz
SRC_FOLDER=groff-1.23.0

k_configure() {
  PAGE=A4 ./configure --prefix=/usr
}
