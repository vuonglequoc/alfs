#!/bin/bash

SRC_FILE=patch-2.7.6.tar.xz
SRC_FOLDER=patch-2.7.6

k_configure() {
  ./configure --prefix=/usr
}
