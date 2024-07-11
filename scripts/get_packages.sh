#!/bin/bash

# Chapter 3. Packages and Patches

# Download required files from wget-list

if mount | grep $LFS > /dev/null; then
  echo
  echo "LFS mount found."
  echo
else
  echo
  echo "No LFS partition found at /mnt/lfs."
  echo
  exit
fi

mkdir -v $LFS/sources

wget --input-file=$LFS/alfs/wget-list --continue --directory-prefix=$LFS/sources

pushd $LFS/sources
  md5sum -c $LFS/alfs/md5sums
popd
