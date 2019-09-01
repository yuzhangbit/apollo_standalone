#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)

cd /tmp && git clone --recursive https://github.com/oxfordcontrol/osqp
cd osqp && mkdir -p build && cd build && cmake ..
make -j$(nproc)
sudo make install
sudo mkdir /usr/local/include/osqp/include
cd /usr/local/include/osqp && sudo cp *.h include/
