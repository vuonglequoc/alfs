#!/bin/bash

SRC_FILE=ninja-1.11.1.tar.gz
SRC_FOLDER=ninja-1.11.1

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
  ./ninja ninja_test
  ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
}

k_install() {
  install -vm755 ninja /usr/bin/
  install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
  install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja
}
