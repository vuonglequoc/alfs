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

# wget --input-file=$LFS/alfs/wget-list --continue --directory-prefix=$LFS/sources
# Support download package with output filename which different with URL
download() {
  err=0
  while read -r url filename; do
    if [ ! -z $filename ]; then
      wget --continue -O "$2/$filename" "$url" || err=1
    else
      wget --continue --directory-prefix="$2" "$url" || err=1
    fi
  done < $1
  return $err
}
download $LFS/alfs/wget-list $LFS/sources

pushd $LFS/sources
  md5sum -c $LFS/alfs/md5sums
popd
