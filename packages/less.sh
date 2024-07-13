#!/bin/bash

SRC_FILE=less-643.tar.gz
SRC_FOLDER=less-643

k_configure() {
  ./configure --prefix=/usr \
              --sysconfdir=/etc
}
