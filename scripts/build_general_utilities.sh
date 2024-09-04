#!/bin/bash

# CMake already built in build_post_lfs
# LLVM-18.1.8
# Rustc-1.79.0

source /alfs/kpkg/kpkg.sh

kpkg_install llvm
kpkg_install libssh2
kpkg_install git
kpkg_install rustc
