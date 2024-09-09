#!/bin/bash

KPKG_SRC_FILE=ninja-1.12.1.tar.gz
KPKG_SRC_FOLDER=ninja-1.12.1

k_pre_configure() {
  export NINJAJOBS=4
}

k_configure() {
sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc
}

k_build() {
  python3 configure.py --bootstrap
}

k_check() {
  # The package tests cannot run in the chroot environment. They require cmake.
  # ./ninja ninja_test
  # ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
  :
}

k_pre_install() {
  install -vDm755 ninja $KPKG_TMP_DIR/usr/bin/ninja
  install -vDm644 misc/bash-completion $KPKG_TMP_DIR/usr/share/bash-completion/completions/ninja
  install -vDm644 misc/zsh-completion  $KPKG_TMP_DIR/usr/share/zsh/site-functions/_ninja
}
