#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install -y libeigen3-dev libboost-all-dev cmake

bash ${CURRENT_DIR}/install_curlpp.sh
bash ${CURRENT_DIR}/install_colpack_adolc.sh
bash ${CURRENT_DIR}/install_glogs_gflags.sh
bash ${CURRENT_DIR}/install_ipopt.sh
bash ${CURRENT_DIR}/install_osqp.sh
bash ${CURRENT_DIR}/install_proj4.sh
bash ${CURRENT_DIR}/install_protobuf.sh
bash ${CURRENT_DIR}/install_qpOASES.sh
bash ${CURRENT_DIR}/install_tinyxml2.sh
