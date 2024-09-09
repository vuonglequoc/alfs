#!/bin/bash

#   LLVM (with Clang)
#       make-ca-1.13
#       Net-SSLeay
#     IO-Socket-SSL-2.085
#     libcap with PAM
#     libevent-2.1.12
#     libedit
#   ntp-4.2.8p17
# dhcpcd-10.0.8

source /alfs/kpkg/kpkg.sh

kpkg_install net-ssleay
kpkg_install io-socket-ssl
kpkg_install libevent
kpkg_install libedit
kpkg_install ntp
kpkg_install dhcpcd

# Wireless: TODO
