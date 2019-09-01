#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)

cd /tmp  && rm -rf qpOASES && git clone https://github.com/robotology-dependencies/qpOASES.git
cd qpOASES
mkdir -p build
cd build
cmake ..
make -j$(nproc)
sudo make install