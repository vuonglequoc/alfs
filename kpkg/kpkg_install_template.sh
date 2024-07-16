#!/bin/bash

cd $KPKG_ROOT/sources
tar xvf $KPKG_SRC_FILE
cd $KPKG_SRC_FOLDER

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

cd $KPKG_ROOT/sources
rm -rf $KPKG_SRC_FOLDER
echo Deleting $KPKG_SRC_FOLDER
echo Done with $KPKG_SRC_FILE
