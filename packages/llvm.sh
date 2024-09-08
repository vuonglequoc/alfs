#!/bin/bash

KPKG_SRC_FILE=llvm-18.1.8.src.tar.xz
KPKG_SRC_FOLDER=llvm-18.1.8.src

k_pre_configure() {
  tar -xf ../llvm-cmake-18.src.tar.xz
  tar -xf ../llvm-third-party-18.src.tar.xz
  sed '/LLVM_COMMON_CMAKE_UTILS/s@../cmake@llvm-cmake-18.src@'          \
      -i CMakeLists.txt
  sed '/LLVM_THIRD_PARTY_DIR/s@../third-party@llvm-third-party-18.src@' \
      -i cmake/modules/HandleLLVMOptions.cmake

  tar -xf ../clang-18.1.8.src.tar.xz -C tools
  mv tools/clang-18.1.8.src tools/clang

  tar -xf ../compiler-rt-18.1.8.src.tar.xz -C projects
  mv projects/compiler-rt-18.1.8.src projects/compiler-rt
  sed '/^set(LLVM_COMMON_CMAKE_UTILS/d'                   \
      -i projects/compiler-rt/CMakeLists.txt

  grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'

  # Same for clang-18
  patch -Np2 -d tools/clang <../clang-17-enable_default_ssp-1.patch

  sed 's/clang_dfsan/& -fno-stack-protector/' \
      -i projects/compiler-rt/test/dfsan/origin_unaligned_memtrans.c

  mkdir -v build
  cd       build
}

k_configure() {
  CC=gcc CXX=g++                              \
  cmake -DCMAKE_INSTALL_PREFIX=/usr           \
        -DLLVM_ENABLE_FFI=ON                  \
        -DCMAKE_BUILD_TYPE=Release            \
        -DLLVM_BUILD_LLVM_DYLIB=ON            \
        -DLLVM_LINK_LLVM_DYLIB=ON             \
        -DLLVM_ENABLE_RTTI=ON                 \
        -DLLVM_TARGETS_TO_BUILD="host;AMDGPU" \
        -DLLVM_BINUTILS_INCDIR=/usr/include   \
        -DLLVM_INCLUDE_BENCHMARKS=OFF         \
        -DCLANG_DEFAULT_PIE_ON_LINUX=ON       \
        -Wno-dev -G Ninja ..
}

k_build() {
  # Make sure we can compile successfully if the hardware resources is not enough
  # and can cause stopping before completing compiling
  ninja
  ninja
  ninja
}

k_check() {
  rm -f ../projects/compiler-rt/test/tsan/getline_nohang.cpp
  sh -c 'ulimit -c 0 && ninja check-all'
}

k_pre_install() {
  DESTDIR=$KPKG_TMP_DIR ninja install
  cp bin/FileCheck $KPKG_TMP_DIR/usr/bin

  mkdir -pv $KPKG_TMP_DIR/etc/clang
  for i in clang clang++; do
    echo -fstack-protector-strong > $KPKG_TMP_DIR/etc/clang/$i.cfg
  done
}
