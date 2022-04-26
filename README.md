# Autorelease GitHub Action
![GitHub last commit](https://img.shields.io/github/last-commit/heitorpolidoro/auto-release)

[![Latest](https://img.shields.io/github/release/heitorpolidoro/auto-release.svg?label=latest)](https://github.com/heitorpolidoro/auto-release/releases/latest)
![GitHub Release Date](https://img.shields.io/github/release-date/heitorpolidoro/auto-release)

![GitHub](https://img.shields.io/github/license/heitorpolidoro/auto-release)

Action to create a release automatically

### Usage
```yaml
name: Create GitHub Release

on:
  push:
    branches:
      - master

jobs:
  create-release:
    name: Create Release
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Create GitHub Release
        id: release
        if: github.event_name == 'push' || github.event.pull_request.merged == true
        uses: heitorpolidoro/auto-release@v1
        with:
          update_released_versions: <true|false> # Default false
          version_file: <filename|path/to/__init__.py> # Default: "VERSION"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Must have a file named `VERSION` in root with the project version in `MAJOR.MINOR.BUGFIX` format.
#### Optional parameters
- `update_released_versions`: Update vX and vX.Y releases. (create or delete and recreate)
- `version_file`: Path to Version file. Can be a file containing just the version or an `__init__.py` file with VERSION 
  defined. Both in `MAJOR.MINOR.BUGFIX` format

VERSION file
```
1.2.3
```

`__init__.py`
```
...
VERSION = '1.2.3'
...
```
PS: GitHub actions user doesn't trigger another workflow, to trigger pass a valid user Personal Access Token to 
`GITHUB_TOKEN` env