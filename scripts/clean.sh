#!/bin/bash

set -e  # exit immediately on error
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
# set -x    # for debuging, trace what is being executed.

cd "$(dirname "$0")/.."

rm -rf ./submodules/ui-js.github.io/*
rm -rf "./build"
rm -rf "./src/build"
