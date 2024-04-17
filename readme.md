# Package Updater

## Requirements

`brew install jq`

## Usage

`yarn update:blacklist`

Dependencies added to the package.json will be not be updated, all other dependencies will be upgraded to their latest version

```json
  "package-updater": {
    "black_list": [
      "react-native-localize"
    ]
  },
```

## Roadmap

- publish as node package
- support for yarn, npm, pnpm etc
- fix annoying JQ error when retrieving outdated dependencies with yarn (see update.sh)
- support for different versions of yarn / npm etc
- Remove requirement for `jq`
- wildcard matching for blacklist
