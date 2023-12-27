#!/bin/bash

source ./setup-env.sh

git clone -b release-1.2.15 https://github.com/libsdl-org/SDL-1.2.git
cd SDL-1.2 
patch -t -p1 < /root/build/patches/rg35xx-sdl-vsync.patch
./autogen.sh 
./configure --host=${HOST} --prefix=${PREFIX}
make clean
make install