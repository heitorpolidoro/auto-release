# Autorelease GitHub Action
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