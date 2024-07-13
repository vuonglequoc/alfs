#!/bin/bash

SRC_FILE=perl-5.38.2.tar.xz
SRC_FOLDER=perl-5.38.2

k_configure() {
  sh Configure -des                                        \
               -Dprefix=/usr                               \
               -Dvendorprefix=/usr                         \
               -Duseshrplib                                \
               -Dprivlib=/usr/lib/perl5/5.38/core_perl     \
               -Darchlib=/usr/lib/perl5/5.38/core_perl     \
               -Dsitelib=/usr/lib/perl5/5.38/site_perl     \
               -Dsitearch=/usr/lib/perl5/5.38/site_perl    \
               -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl \
               -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl
}

k_check() {
  :
}
