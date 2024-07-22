#!/bin/bash

# CMake already built in build_post_lfs
# LLVM-18.1.8
# Rustc-1.79.0

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages llvm
kpkg_install /alfs packages libssh2
kpkg_install /alfs packages git
kpkg_install /alfs packages rustc
