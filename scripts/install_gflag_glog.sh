#!/usr/bin/env bash
set -e  # exit on first error
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UBUNTU_CODENAME=$(lsb_release -sc)

main()
{
    sudo apt-get install -y libgflags-dev libgoogle-glog-dev
}

main



