#!/bin/bash

source /alfs/kpkg/kpkg.sh

# Chapter 7. Entering Chroot and Building Additional Temporary Tools

# 7.7. Gettext-0.22.4
kpkg_install native-temp-tools/gettext

# 7.8. Bison-3.8.2
kpkg_install native-temp-tools/bison

# 7.9. Perl-5.38.2
kpkg_install native-temp-tools/perl

# 7.10. Python-3.12.2
kpkg_install native-temp-tools/python

# 7.11. Texinfo-7.1
kpkg_install native-temp-tools/texinfo

# 7.12. Util-linux-2.39.3
kpkg_install native-temp-tools/util-linux

# 7.13. Cleaning up and Saving the Temporary System
rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools
