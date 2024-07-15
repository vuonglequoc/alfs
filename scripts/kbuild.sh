#!/bin/bash

# Make kbuild function
timestamp() {
  date +%d-%m-%Y_%H:%M:%S
}

kpkg_build()
{
  # sample: kpkg_build $ALFS toolchain gcc
  if [ ! -d "$1/logs/$2" ]; then
    mkdir -p $1/logs/$2
  fi

  echo "$(timestamp) $3 start"
  echo "$(timestamp) $3 start" >> $1/logs/build.log

  export KROOT

  source $1/scripts/kpkg_template.sh
  source $1/$2/$3.sh

  if [[ "$K_RECORD" -eq 1 ]]; then
    if [ ! -d "$KPKG_DEST_DIR" ]; then
      mkdir -p $KPKG_DEST_DIR
    fi
  fi

  export K_RECORD
  export KPKG_DIR
  export KPKG_DEST_DIR
  export SRC_FILE
  export SRC_FOLDER
  export -f k_pre_configure
  export -f k_configure
  export -f k_build
  export -f k_check
  export -f k_install
  export -f k_post_install
  export -f k_pre_record
  export -f k_record

  $1/scripts/kbuild_template.sh 1> $1/logs/$2/$3.log 2> $1/logs/$2/$3.err.log

  unset KROOT
  unset K_RECORD
  unset KPKG_DIR
  unset KPKG_DEST_DIR
  unset SRC_FILE
  unset SRC_FOLDER
  unset k_pre_configure
  unset k_configure
  unset k_build
  unset k_check
  unset k_install
  unset k_post_install
  unset k_pre_record
  unset k_record

  echo "$(timestamp) $3 end"
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
  K_RECORD=0
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

  KROOT=
  K_RECORD=1
  kpkg_build $1 $2 $3
}
