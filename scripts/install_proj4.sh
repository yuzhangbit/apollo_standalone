#!/usr/bin/env bash
cd /tmp
wget https://download.osgeo.org/proj/proj-4.9.3.tar.gz

tar -xvzf proj-4.9.3.tar.gz
cd proj-4.9.3 && mkdir build && cd build
cmake .. && make -j4
sudo make install