#!/usr/bin/env bash

set -e

# ccache on OS X needs installation first
# reset ccache statistics
ccache --zero-stats

echo PATH=${PATH}

echo "Compiler configuration:"
echo CXX=${CXX}
echo CC=${CC}
echo CXXFLAGS=${CXXFLAGS}

echo "C++ compiler version:"
${CXX} --version || echo "${CXX} does not seem to support the --version flag"
${CXX} -v || echo "${CXX} does not seem to support the -v flag"

echo "C compiler version:"
${CC} --version || echo "${CC} does not seem to support the --version flag"
${CC} -v || echo "${CC} does not seem to support the -v flag"
