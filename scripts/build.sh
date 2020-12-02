#!/bin/bash

set -e  # exit immediately on error
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
# set -x    # for debuging, trace what is being executed.

cd "$(dirname "$0")/.."

# Read the first argument, set it to "dev" if not set
ENVIRONMENT="${1-dev}"

# Remove the CNAME file, which is used
# to indicate if this is a production or development build
[ -f "./submodules/ui-js.github.io/CNAME" ] && rm "./submodules/ui-js.github.io/CNAME"

mkdir -p ./build
mkdir -p ./src/build

grok() {
    node ./submodules/grok/bin/grok-cli $@
}

## Grok (.d.ts -> .html with frontmatter)
# Uses grok.config.js for additional config option
# node ./submodules/grok/bin/grok-cli  ./node_modules/mathlive/dist/ --outDir ./src/build/ --outFile mathlive.html
grok ./submodules/web-components/src/menus/ --outDir ./src/build/ --outFile menus.html

## Copy dependencies and submodules
mkdir -p ./submodules/ui-js.github.io/assets/js/
cp ./node_modules/@ui-js/code-playground/dist/code-playground.js ./submodules/ui-js.github.io/assets/js/code-playground.js
cp -r ./submodules/web-components/dist/* ./submodules/ui-js.github.io/assets/js

## Collect all the relevant markdown files
node ./scripts/build-md.js

## Build (.md -> .html)
# DEBUG=Eleventy* npx eleventy --config ./config/eleventy.js
if [ "$ENVIRONMENT" != "watch" ]
then
    # In watch mode, no need to do a build, the watch call will do it later.
    npx eleventy --config ./config/eleventy.js
fi

if [ "$ENVIRONMENT" == "production" ]
then
    echo "Making a prod build"
    sync
    npx html-minifier-terser \
        --config-file "./config/html-minifier.json" \
        --file-ext html \
        --input-dir "./submodules/ui-js.github.io/" \
        --output-dir "./submodules/ui-js.github.io/"
    postcss --config "./config" --replace "./submodules/ui-js.github.io/**/*.css"

fi
