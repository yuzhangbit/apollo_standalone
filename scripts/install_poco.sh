#!/usr/bin/env bash

# Fail on first error.
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

# Ubuntu 14.04 has poco package version 1.3.6
# if a higher version is required, the below
# will install from source
#sudo apt-get -y update && sudo apt-get -y install poco


# Install from source
VERSION=1.9.0

wget https://github.com/pocoproject/poco/archive/poco-${VERSION}-release.tar.gz
tar -xf poco-${VERSION}-release.tar.gz

# we cant use cmake because poco requires > 3.2
# and the container is at 2.8
# but standard ./configure && make works fine
# ref: https://pocoproject.org/docs/00200-GettingStarted.html

pushd poco-poco-${VERSION}-release
  ./configure --omit=Data/ODBC,Data/MySQL && \
         sudo make -s -j`nproc` && \
         sudo make -s -j`nproc` install
popd

# clean up
sudo rm -rf poco-${VERSION}-release.tar.gz poco-poco-${VERSION}-release
