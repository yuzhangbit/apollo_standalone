#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


cd ${CURRENT_DIR}
./install_curlpp.sh