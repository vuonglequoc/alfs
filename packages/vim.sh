#!/bin/bash

SRC_FILE=vim-9.1.0041.tar.gz
SRC_FOLDER=vim-9.1.0041

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

k_post_install() {
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim91/doc /usr/share/doc/vim-9.1.0041

cat > /etc/vimrc << "EOF"
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
