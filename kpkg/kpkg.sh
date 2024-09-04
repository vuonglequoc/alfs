#!/bin/bash

# Make kpkg functions
timestamp() {
  date +%d-%m-%Y_%H:%M:%S
}

kpkg_install_proc()
{
  # sample: kpkg_install_proc $ALFS gcc
  if [[ $2 == *"/"* ]]; then
    sub_dir=$(dirname "$2")
  else
    sub_dir=""
  fi

  if [ ! -d "$1/logs/packages/$sub_dir" ]; then
    mkdir -p $1/logs/packages/$sub_dir
  fi

  echo "$(timestamp) $2 start"
  echo "$(timestamp) $2 start" >> $1/logs/build.log

  export KPKG_ROOT

  source $1/kpkg/kpkg_template.sh
  source $1/packages/$2.sh

  if [[ "$KPKG_RECORD" -eq 1 ]]; then
    if [ ! -d "$KPKG_TMP_DIR" ]; then
      mkdir -p $KPKG_TMP_DIR
    fi
  fi

  export KPKG_RECORD
  export KPKG_DIR
  export KPKG_TMP_DIR
  export KPKG_SRC_FILE
  export KPKG_SRC_FOLDER
  export -f k_prepare_source
  export -f k_pre_configure
  export -f k_configure
  export -f k_build
  export -f k_check
  export -f k_install
  export -f k_post_install
  export -f k_pre_record
  export -f k_record
  export -f k_build_clean

  $1/kpkg/kpkg_install_template.sh 1> $1/logs/packages/$2.log 2> $1/logs/packages/$2.err.log

  unset KPKG_ROOT
  unset KPKG_RECORD
  unset KPKG_DIR
  unset KPKG_TMP_DIR
  unset KPKG_SRC_FILE
  unset KPKG_SRC_FOLDER
  unset k_prepare_source
  unset k_pre_configure
  unset k_configure
  unset k_build
  unset k_check
  unset k_install
  unset k_post_install
  unset k_pre_record
  unset k_record
  unset k_build_clean

  echo "$(timestamp) $2 end"
  echo "$(timestamp) $2 end" >> $1/logs/build.log
}

kpkg_installtool()
{
  # sample: kpkg_installtool gcc
  if [ "$(whoami)" != "lfs" ]; then
    echo "Script must be run as user: lfs"
    echo "sudo su lfs"
    exit 255
  fi

  KPKG_ROOT=$LFS
  KPKG_RECORD=0
  kpkg_install_proc $ALFS $1
}

kpkg_install()
{
  # sample: kpkg_install gcc
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    echo "sudo su"
    exit
  fi

  KPKG_ROOT=
  KPKG_RECORD=1
  kpkg_install_proc /alfs $1
}
