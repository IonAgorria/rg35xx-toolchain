#!/bin/bash

set -e

BOOST_VER=68

# Download boost, untar, setup install with bootstrap and install
wget "http://downloads.sourceforge.net/project/boost/boost/1.${BOOST_VER}.0/boost_1_${BOOST_VER}_0.tar.gz"
tar xfvz "./boost_1_${BOOST_VER}_0.tar.gz"
rm "./boost_1_${BOOST_VER}_0.tar.gz"
mv "./boost_1_${BOOST_VER}_0" ./boost
      
cd /root/build/boost
./bootstrap.sh --prefix="/opt/miyoo/arm-miyoo-linux-uclibcgnueabi/sysroot/usr/"

source /root/build/setup-env.sh

#Substitute system gcc with our toolchain
sed -i 's/using gcc ;/using gcc : miyoo : arm-miyoo-linux-uclibcgnueabi-g++ ;/g' project-config.jam

#We install all except some that fail to compile
./b2 toolset=gcc-miyoo install \
   --with-atomic --with-chrono --with-container --with-context --with-contract \
   --with-coroutine --with-date_time --with-exception --with-fiber --with-filesystem \
   --with-graph --with-graph_parallel --with-iostreams --with-log --with-math \
   --with-mpi --with-program_options --with-random --with-regex \
   --with-serialization --with-signals --with-stacktrace --with-system --with-test \
   --with-thread --with-timer --with-type_erasure --with-wave
