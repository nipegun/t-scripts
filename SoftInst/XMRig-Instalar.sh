#!/bin/bash

pkg update
pkg upgrade
pkg install git
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
pkg install cmake
cmake ..

