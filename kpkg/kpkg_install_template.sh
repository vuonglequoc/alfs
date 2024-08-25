#!/bin/bash

k_prepare_source
k_pre_configure
k_configure
k_build
k_check
k_install
k_post_install
if [[ "$KPKG_RECORD" -eq 1 ]]; then
  k_pre_record
  k_record
fi
k_build_clean

echo Done with $KPKG_SRC_FILE
