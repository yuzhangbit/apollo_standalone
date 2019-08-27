#!/usr/bin/env bash

set -ev

if [ "${TRAVIS_OS_NAME}" != linux ]; then
    echo "Not a Linux build; skipping installation"
    exit 0
fi

for f in ./scripts/*.sh; do
    bash "$f" -H || break
done

# sudo apt-get update
# sudo apt-get install -y
