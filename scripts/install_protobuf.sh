#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)
VERSION="3.3.0"
LANG="cpp"  # any of  all,cpp,  java, csharp, ruby, python
main()
{
    install_dependencies
    install_protobuf
}

install_dependencies()
{
    sudo apt-get -y install autoconf automake libtool curl make g++ unzip
}


install_protobuf()
{
    echo "Installing protobuf....."
    cd /tmp
    rm -rf protobuf-${LANG}-${VERSION}.tar.gz
    wget https://github.com/protocolbuffers/protobuf/releases/download/v${VERSION}/protobuf-${LANG}-${VERSION}.tar.gz
    tar xzf protobuf-${LANG}-${VERSION}.tar.gz
    cd protobuf-${VERSION}
    ./autogen.sh
    # Our policy is install into /usr/local; and don't install into /usr.
    # Installing the library into /usr on some platforms breaks the library
    # because the compiler treats all headers in /usr/include as C files,
    # and not C++ header files. OpenBSD is one that breaks us, but it handles
    # the library header files as expected when they are installed into
    # /usr/local/include
    # A whole bunch of libraries of ROS depend on libprotobuf-dev that comes with
    # the system.  Be careful with the installation directory
    #export CC=/usr/local/bin/gcc
    #export CXX=/usr/local/bin/g++
    ./configure --prefix=/usr/local --with-pic  # default is /usr/local
    make -j4
    sudo make install
    # Some of the headers won't be installed by default using configure script, we do it manually
    cd src/google/protobuf/stubs && sudo cp -r *.h /usr/local/include/google/protobuf/stubs/ && cd -
    cd ..
    sudo ldconfig
    rm -rf protobuf-${LANG}-${VERSION}.tar.gz
    echo "protobuf version ${VERSION} installed."
}


main
