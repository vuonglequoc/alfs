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

  # Fix locale.c:8812:43: error: 'PERL_LC_ALL_CATEGORY_POSITIONS_INIT' undeclared
  # Fix locale.c: In function 'Perl_init_i18nl10n':
  # perl.h:4280:36: error: negative width in bit-field '__error_if_negative'
  # 4280 | efine STATIC_ASSERT_DECL(COND) static_assert(COND, #COND)
  #       |                                ^~~~~~~~~~~~~

  # perl.h:4296:52: note: in expansion of macro 'STATIC_ASSERT_DECL'
  # 4296 | T_STMT(COND)      STMT_START { STATIC_ASSERT_DECL(COND); } STMT_END
  #       |                                ^~~~~~~~~~~~~~~~~~

  # locale.c:8813:9: note: in expansion of macro 'STATIC_ASSERT_STMT'
  # 8813 |         STATIC_ASSERT_STMT(   C_ARRAY_LENGTH(lc_all_category_positions)
  # https://github.com/openwrt/packages/issues/24512#issuecomment-2212506831
  patch -i /alfs/patches/perl-5.40.0-locale_fixes-1.patch
}

k_check() {
  :
}
