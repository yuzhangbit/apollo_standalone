#!/bin/bash
set -e # exit on first error
SOURCE_DIR="/tmp"

install_ipopt()
{
    sudo add-apt-repository universe &&  sudo apt-get -y update
    sudo apt-get install -y libblas-dev liblapack-dev gfortran
    cd ${SOURCE_DIR} && rm -rf Ipopt
    git clone --recursive https://github.com/coin-or/Ipopt.git
    cd Ipopt && git checkout releases/3.12.11
    ./configure --prefix /usr/local --disable-shared ADD_CXXFLAGS="-fPIC" ADD_CFLAGS="-fPIC" ADD_FFLAGS="-fPIC"
    make -j8 all
    sudo make install
}

install_ipopt