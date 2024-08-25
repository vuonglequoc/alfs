#!/bin/bash

KPKG_SRC_FILE=perl-5.38.2.tar.xz
KPKG_SRC_FOLDER=perl-5.38.2

k_pre_configure() {
  export BUILD_ZLIB=False
  export BUILD_BZIP2=0
}

k_configure() {
  sh Configure -des                                         \
               -Dprefix=/usr                                \
               -Dvendorprefix=/usr                          \
               -Dprivlib=/usr/lib/perl5/5.38/core_perl      \
               -Darchlib=/usr/lib/perl5/5.38/core_perl      \
               -Dsitelib=/usr/lib/perl5/5.38/site_perl      \
               -Dsitearch=/usr/lib/perl5/5.38/site_perl     \
               -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl  \
               -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl \
               -Dman1dir=/usr/share/man/man1                \
               -Dman3dir=/usr/share/man/man3                \
               -Dpager="/usr/bin/less -isR"                 \
               -Duseshrplib                                 \
               -Dusethreads
}

k_check() {
  TEST_JOBS=$(nproc) make test_harness
}

k_post_install() {
  unset BUILD_ZLIB BUILD_BZIP2
}
