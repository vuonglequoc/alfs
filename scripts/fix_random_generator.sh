#!/bin/bash

cd /sources
tar -xf blfs-bootscripts-20240416.tar.xz
cd blfs-bootscripts-20240416
make install-random
cd /sources
rm -r blfs-bootscripts-20240416
