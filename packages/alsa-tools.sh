#!/bin/bash

KPKG_SRC_FILE=alsa-tools-1.2.11.tar.bz2
KPKG_SRC_FOLDER=alsa-tools-1.2.11

k_configure() {
  :
}

k_build() {
  log_path=/alfs/logs/packages/$KPKG_DIST_SUB_DIR/$KPKG_SRC_FOLDER
  mkdir -pv $log_path/seq

  # bash -e
  rm -rf qlo10k1 Makefile gitcompile

  # Build limited tools for working without GUI libraries
  # GTK+-2
  rm -rf echomixer envy24control rmedigicontrol
  # GTK+-3.24.43
  rm -rf hdajackretask hdajacksensetest
  # FLTK-1.3.9
  rm -rf hdspconf hdspmixer

  for tool in *
  do
    case $tool in
      seq )
        tool_dir=seq/sbiload
      ;;
      * )
        tool_dir=$tool
      ;;
    esac

    pushd $tool_dir
      echo ===== Build tool $tool_dir =====
      ./configure --prefix=/usr
      make > $log_path/$tool_dir.log
      make DESTDIR=$KPKG_TMP_DIR install >> $log_path/$tool_dir.log
    popd
  done
  unset tool tool_dir
  # exit

  unset log_path
}

k_check() {
  :
}

k_pre_install() {
  :
}

k_post_install() {
  /sbin/ldconfig
}
