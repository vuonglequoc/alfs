#!/bin/bash

#   LLVM-17.0.6 (with Clang)
#       make-ca-1.13
#       Net-SSLeay-1.92
#     IO-Socket-SSL-2.085
#     libcap-2.69 with PAM
#     libevent-2.1.12
#     libedit
#   ntp-4.2.8p17
# dhcpcd-10.0.8

source /alfs/kpkg/kpkg.sh

kpkg_install /alfs packages net-ssleay
kpkg_install /alfs packages io-socket-ssl
kpkg_install /alfs packages libevent
kpkg_install /alfs packages libedit
kpkg_install /alfs packages ntp
kpkg_install /alfs packages dhcpcd

# Wireless: TODO
