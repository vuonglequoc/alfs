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

cd $KROOT/sources
rm -rf $SRC_FOLDER
echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
