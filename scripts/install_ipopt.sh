#!/bin/bash
set -e # exit on first error
SOURCE_DIR="/tmp"

install_ipopt()
{
    #sudo add-apt-repository universe && apt-get -y update
    #sudo apt-get install -y libblas-dev liblapack-dev gfortran
    cd /tmp
    wget https://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.11.zip -O Ipopt-3.12.11.zip
    unzip Ipopt-3.12.11.zip
    cd Ipopt-3.12.11/ThirdParty/Mumps
    bash get.Mumps
    cd /tmp/Ipopt-3.12.11
    ./configure --prefix /usr/local --disable-shared ADD_CXXFLAGS="-fPIC" ADD_CFLAGS="-fPIC" ADD_FFLAGS="-fPIC"
    make -j8 all
    sudo make install
}

install_ipopt