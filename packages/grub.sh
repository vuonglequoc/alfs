#!/bin/bash

SRC_FILE=grub-2.12.tar.xz
SRC_FOLDER=grub-2.12

k_pre_configure() {
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

k_post_install() {
  mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions
}
