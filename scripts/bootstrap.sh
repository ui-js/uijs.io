#!/bin/bash

# scripts/bootstrap.sh 
# Resolve all dependencies that the project requires to run.

set -e

cd "$(dirname "$0")/.."

# If the node_modules have not been installed yet, install them now.
if [ ! -d node_modules ]; then
  npm install
fi

npx lerna run --scope @ui-js/grok build
npx lerna run --scope @ui-js/web-components build
