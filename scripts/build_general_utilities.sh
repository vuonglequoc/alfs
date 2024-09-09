#!/bin/bash

# CMake already built in build_post_lfs
# LLVM
# Rustc

source /alfs/kpkg/kpkg.sh

kpkg_install llvm
kpkg_install libssh2
kpkg_install git
kpkg_install rustc
