#!/bin/bash

set -e  # exit immediately on error
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
# set -x    # for debuging, trace what is being executed.

cd "$(dirname "$0")/.."

tput sc # save cursor

echo "Deploying..."

if [ ! -d "submodules/ui-js.github.io" ]; then
    echo "Execute \"npm run stage\" first"
    exit 1
fi

if [ ! -f "./submodules/ui-js.github.io/CNAME" ]; then
    echo "Execute \"npm run stage\" first"
    exit 1
fi

# Push the content of the submodules/ui-js.github.io directory, which is mapped to 
# ui-js.github.io as a submodule.
cd "./submodules/ui-js.github.io"
git fetch
git checkout master
git add .
git commit -a -m "`date +\"%Y-%m-%d\"`"
git push origin master:master

tput rc;tput el # rc = restore cursor, el = erase to end of line

echo "Deployed."