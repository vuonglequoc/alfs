#!/bin/bash

# Make kbuild function
timestamp() {
  date +%d-%m-%Y_%H:%M:%S
}

kpkg_build()
{
  # sample: kpkg_build $ALFS toolchain gcc
  echo "$(timestamp) $3 start" >> $1/logs/build.log

  source $1/scripts/kpkg_template.sh
  source $1/$2/$3.sh

  export KROOT
  export SRC_FILE
  export SRC_FOLDER
  export -f k_pre_configure
  export -f k_configure
  export -f k_build
  export -f k_check
  export -f k_install
  export -f k_post_install

  $1/scripts/kbuild_template.sh 1> $1/logs/$2/$3.log 2> $1/logs/$2/$3.err.log

  unset KROOT
  unset SRC_FILE
  unset SRC_FOLDER
  unset k_pre_configure
  unset k_configure
  unset k_build
  unset k_check
  unset k_install
  unset k_post_install

  echo "$(timestamp) $3 end" >> $1/logs/build.log
}

kbuildtool()
{
  # sample: kbuildtool $ALFS toolchain gcc
  if [ "$(whoami)" != "lfs" ]; then
    echo "Script must be run as user: lfs"
    echo "sudo su lfs"
    exit 255
  fi

  KROOT=$LFS
  kpkg_build $1 $2 $3
}

kbuild()
{
  # sample: kbuild /alfs packages gcc
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    echo "sudo su"
    exit
  fi

  KROOT=/
  kpkg_build $1 $2 $3
}
