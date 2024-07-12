#!/bin/bash

source /alfs/scripts/kbuild.sh

# Chapter 7. Entering Chroot and Building Additional Temporary Tools

# 7.7. Gettext-0.22.4
kbuild /alfs toolchain gettext

# 7.8. Bison-3.8.2
kbuild /alfs toolchain bison

# 7.9. Perl-5.38.2
kbuild /alfs toolchain perl

# 7.10. Python-3.12.2
kbuild /alfs toolchain python

# 7.11. Texinfo-7.1
kbuild /alfs toolchain texinfo

# 7.12. Util-linux-2.39.3
kbuild /alfs toolchain util-linux

# 7.13. Cleaning up and Saving the Temporary System
rm -rf /usr/share/{info,man,doc}/*

find /usr/{lib,libexec} -name \*.la -delete

rm -rf /tools
