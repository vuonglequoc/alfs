#!/bin/bash

cat > /etc/skel/.vimrc << "EOF"
" Begin .vimrc

set columns=80
set wrapmargin=8
set ruler

" End .vimrc
EOF
cp /etc/skel/.vimrc /home/$NONROOT_USER/.vimrc
