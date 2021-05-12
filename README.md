# ui-js.io

This website is hosted as a GitHub Page at `ui-js.github.io`.

```bash
# Update the GitHub repo
npm run stage

# Push the update live
npm run deploy
```

## Development

This is a static website built with `eleventy`. The content is in `src/_pages`
and extracted from the `.md` files in `submodules/web-components` (see
`scripts/build-guides.js`).

The Home Page is

The top level menu bar is specified in `src/_data/navigation.json` in the `main`
property.

```bash
# Build and start local server
npm run start
```
