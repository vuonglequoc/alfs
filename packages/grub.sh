#!/bin/bash

KPKG_SRC_FILE=grub-2.12.tar.xz
KPKG_SRC_FOLDER=grub-2.12

k_pre_configure() {
  # For build `unicode.pf2`, need install unifont to system firstly
  mkdir -pv /usr/share/fonts/unifont
  gunzip -c ../unifont-15.1.04.pcf.gz > /usr/share/fonts/unifont/unifont.pcf

  unset {C,CPP,CXX,LD}FLAGS

  echo depends bli part_gpt > grub-core/extra_deps.lst
}

k_configure() {
  ./configure --prefix=/usr        \
              --sysconfdir=/etc    \
              --disable-efiemu     \
              --enable-grub-mkfont \
              --with-platform=efi  \
              --target=x86_64      \
              --disable-werror

  unset TARGET_CC
}

k_check() {
  :
}

k_pre_install() {
  make DESTDIR=$KPKG_TMP_DIR install

  mkdir -pv $KPKG_TMP_DIR/usr/share/bash-completion/completions
  mv -v $KPKG_TMP_DIR/etc/bash_completion.d/grub $KPKG_TMP_DIR/usr/share/bash-completion/completions

  # Prepare for GRUB's graphical
  mkdir -pv $KPKG_TMP_DIR/boot/grub/fonts
  cp $KPKG_TMP_DIR/usr/share/grub/unicode.pf2 $KPKG_TMP_DIR/boot/grub/fonts/unicode.pf2
}
