#!/bin/bash

SRC_FILE=XML-Parser-2.47.tar.gz
SRC_FOLDER=XML-Parser-2.47

k_configure() {
  perl Makefile.PL
}

k_check() {
  make test
}
