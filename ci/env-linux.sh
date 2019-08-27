#!/usr/bin/env bash

#
# This file should be sourced, and not executed as a standalone script.
#

# TODO() - we can check if this is being sourced using $BASH_VERSION and $BASH_SOURCE[0] != ${0}.

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
    if [ "$CXX" = "g++" ]; then export CXX="g++-4.9" CC="gcc-4.9"; fi
    # if [ "$CXX" = "clang++" ]; then export CXX="clang++-3.9" CC="clang-3.9"; fi
fi
