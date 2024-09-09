#!/bin/bash

source /alfs/kpkg/kpkg.sh

# Chapter 7. Entering Chroot and Building Additional Temporary Tools
kpkg_install native-temp-tools/gettext
kpkg_install native-temp-tools/bison
kpkg_install native-temp-tools/perl
kpkg_install native-temp-tools/python
kpkg_install native-temp-tools/texinfo
kpkg_install native-temp-tools/util-linux

# 7.13. Cleaning up and Saving the Temporary System
rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools
