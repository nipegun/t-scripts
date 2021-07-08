#!/bin/bash

pkg update
pkg upgrade
pkg install -y git
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
pkg install -y cmake
cmake .. -DWITH_HWLOC=OFF
make -j $(nproc)
./xmrig -o pool.minexmr.com:4444 -u 451K8ZpJTWdLBKb5uCR1EWM5YfCUxdgxWFjYrvKSTaWpH1zdz22JDQBQeZCw7wZjRm3wqKTjnp9NKZpfyUzncXCJ24H4Xtr
#/data/data/com.termux/files/home/xmrig/build/xmrig

