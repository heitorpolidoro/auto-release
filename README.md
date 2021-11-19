# Autorelease GitHub Action
[![Create GitHub Release](https://github.com/heitorpolidoro/auto-release/actions/workflows/auto-release.yml/badge.svg)](https://github.com/heitorpolidoro/auto-release/actions/workflows/auto-release.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/heitorpolidoro/auto-release)

[![Latest](https://img.shields.io/github/release/heitorpolidoro/auto-release.svg?label=latest)](https://github.com/heitorpolidoro/auto-release/releases/latest)
![GitHub Release Date](https://img.shields.io/github/release-date/heitorpolidoro/auto-release)

![GitHub](https://img.shields.io/github/license/heitorpolidoro/auto-release)

Action to create a release automatically

### Usage
```yaml
    steps:
      - uses: actions/checkout@v2

      - name: Create GitHub Release
        uses: heitorpolidoro/auto-release@v1
        with:
          personal_access_token: ${{ secrets.PAT }}
```
Must have a file named `VERSION` in root with the project version in `MAJOR.MINOR.BUGFIX` format.
#### Optional parameters
```yaml
allowed_users: List of github users allowed to trigger auto-release.
version_file: Path to Version file
update_released_versions: Update vX and vX.Y releases. (create or delete and recreate)
```