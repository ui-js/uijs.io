## Adding a submodule

```bash
git submodule add -b master https://github.com/cortex-js/<PROJECT>.git submodules/<PROJECT>
git submodule init
```

```
git submodule add -b master https://github.com/ui-js/code-playground.git submodules/code-playground

git submodule add -b main https://github.com/ui-js/web-components.git submodules/web-components

git submodule add -b master https://github.com/ui-js/grok.git submodules/grok
git submodule add -b main https://github.com/ui-js/ui-js.github.io.git submodules/ui-js.github.io


[submodule "submodules/web-components"]
	path = submodules/web-components
	url = https://github.com/ui-js/web-components.git
	branch = main
```

**Note**: git tracks the submodules in a `.gitmodules` file.

## Getting/updating a submodule

After doing a check-out of the parent project, for example.

```bash
git submodule init
```

Alternatively, use the `--recursive` option when cloning:
(`--jobs 8` requests parallel installs to take place)

```
git clone --recursive --jobs 8 <URL TO GIT REPO>
```

## Pulling changes in the main module and the submodules

```bash
git pull --recurse-submodules
```

## Manually updating the submodule

```bash
git submodule update --remote
```
