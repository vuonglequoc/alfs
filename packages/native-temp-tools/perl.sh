#!/bin/bash

KPKG_SRC_FILE=perl-5.40.0.tar.xz
KPKG_SRC_FOLDER=perl-5.40.0

k_configure() {
  sh Configure -des                                         \
              -D prefix=/usr                               \
              -D vendorprefix=/usr                         \
              -D useshrplib                                \
              -D privlib=/usr/lib/perl5/5.40/core_perl     \
              -D archlib=/usr/lib/perl5/5.40/core_perl     \
              -D sitelib=/usr/lib/perl5/5.40/site_perl     \
              -D sitearch=/usr/lib/perl5/5.40/site_perl    \
              -D vendorlib=/usr/lib/perl5/5.40/vendor_perl \
              -D vendorarch=/usr/lib/perl5/5.40/vendor_perl
}

k_check() {
  :
}
