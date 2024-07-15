#!/bin/bash

cd $KROOT/sources
tar xvf $SRC_FILE
cd $SRC_FOLDER

k_pre_configure
k_configure
k_build
k_check
k_install
k_post_install
if [[ "$K_RECORD" -eq 1 ]]; then
  k_pre_record
  k_record
fi

cd $KROOT/sources
rm -rf $SRC_FOLDER
echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
