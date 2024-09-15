#!/bin/bash

KPKG_SRC_FILE=vim-9.1.0722.tar.gz
KPKG_SRC_FOLDER=vim-9.1.0722

k_pre_configure() {
  echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
}

k_configure() {
  ./configure --prefix=/usr
}

k_check() {
  chown -Rv tester .
  su tester -c "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" \
    &> vim-test.log
}

k_pre_install() {
make DESTDIR=$KPKG_TMP_DIR install

ln -sv vim $KPKG_TMP_DIR/usr/bin/vi
for L in  $KPKG_TMP_DIR/usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

mkdir -pv $KPKG_TMP_DIR/usr/share/doc
ln -sv ../vim/vim91/doc $KPKG_TMP_DIR/usr/share/doc/vim-9.1.0722

mkdir -pv $KPKG_TMP_DIR/etc
cat > $KPKG_TMP_DIR/etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF
}
