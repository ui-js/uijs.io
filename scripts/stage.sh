#!/bin/bash

set -e  # exit immediately on error
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
# set -x    # for debuging, trace what is being executed.

cd "$(dirname "$0")/.."

# Make a build

./scripts/setup.sh
./scripts/build.sh production
./scripts/test.sh

# Add the .nojekyll file to prevent GH Pages from processing the content
touch submodules/ui-js.github.io/.nojekyll

# Add CNAME file
printf "uijs.io" >submodules/ui-js.github.io/CNAME

