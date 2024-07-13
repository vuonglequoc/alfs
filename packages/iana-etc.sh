#!/bin/bash

SRC_FILE=iana-etc-20240125.tar.gz
SRC_FOLDER=iana-etc-20240125

k_configure() {
  :
}

k_build() {
  :
}

k_check() {
  :
}

k_install() {
  cp services protocols /etc
}
