#!/bin/bash

k_prepare_source
k_pre_configure
k_configure
k_build
k_check
k_pre_install
k_install
k_post_install
k_build_clean

echo Done with $KPKG_SRC_FILE
