#!/bin/bash

KPKG_DIR=$KPKG_ROOT/etc/kpkg
KPKG_LOG_DIR=$KPKG_DIR/log
KPKG_DIST_DIR=$KPKG_DIR/dist
KPKG_TMP_DIR=$KPKG_DIR/tmp
KPKG_LIST_FILE=$KPKG_DIR/list

KPKG_SRC_FILE=
KPKG_SRC_FOLDER=

k_prepare_source() {
  cd $KPKG_ROOT/sources

  echo "Extracting source file..."
  tar xvf $KPKG_SRC_FILE

  cd $KPKG_SRC_FOLDER
}

k_pre_configure() {
  :
  # mkdir build
  # cd    build
}

k_configure() {
  ./configure
  # meson setup ..
}

k_build() {
  make
  # ninja
}

k_check() {
  make check
  # ninja test
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install
  # DESTDIR=$KPKG_TMP_DIR ninja install
}

k_install() {
  INSTALL_TIME=$(timestamp)
  DIST_FILE=$KPKG_DIST_DIR/${KPKG_SRC_FOLDER}_$INSTALL_TIME.tar.xz

  pushd $KPKG_TMP_DIR
    # Record
    if [[ "$KPKG_RECORD" -eq 1 ]]; then
      # Info
      echo "$INSTALL_TIME $KPKG_SRC_FOLDER" >> $KPKG_LIST_FILE
      # Detail
      find . -type f > $KPKG_LOG_DIR/$KPKG_SRC_FOLDER.dest
      sed -i "s/.\//\//" $KPKG_LOG_DIR/$KPKG_SRC_FOLDER.dest
    fi

    # Compress
    tar -cJpf $DIST_FILE .

    # Clean KPKG_TMP_DIR
    rm -rf ./*
  popd

  pushd $KPKG_ROOT/
    # Install by untar instead of cp command
    # Because cp command can cause "Bus error" while overwrite using lib
    tar -xpf $DIST_FILE
  popd
}

k_post_install() {
  :
}

k_build_clean() {
  cd $KPKG_ROOT/sources
  rm -rf $KPKG_SRC_FOLDER
  echo Deleting $KPKG_SRC_FOLDER
}
