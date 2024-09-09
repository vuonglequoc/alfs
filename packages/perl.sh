#!/bin/bash

KPKG_SRC_FILE=perl-5.40.0.tar.xz
KPKG_SRC_FOLDER=perl-5.40.0

k_pre_configure() {
  export BUILD_ZLIB=False
  export BUILD_BZIP2=0
}

k_configure() {
  sh Configure -des                                          \
              -D prefix=/usr                                \
              -D vendorprefix=/usr                          \
              -D privlib=/usr/lib/perl5/5.40/core_perl      \
              -D archlib=/usr/lib/perl5/5.40/core_perl      \
              -D sitelib=/usr/lib/perl5/5.40/site_perl      \
              -D sitearch=/usr/lib/perl5/5.40/site_perl     \
              -D vendorlib=/usr/lib/perl5/5.40/vendor_perl  \
              -D vendorarch=/usr/lib/perl5/5.40/vendor_perl \
              -D man1dir=/usr/share/man/man1                \
              -D man3dir=/usr/share/man/man3                \
              -D pager="/usr/bin/less -isR"                 \
              -D useshrplib                                 \
              -D usethreads
}

k_check() {
  TEST_JOBS=$(nproc) make test_harness
}

k_post_install() {
  unset BUILD_ZLIB BUILD_BZIP2
}
