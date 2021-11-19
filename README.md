# Autorelease GitHub Action
Action to create a release automatically

### Usage
```yaml
    steps:
      - uses: actions/checkout@v2

      - name: Create GitHub Release
        uses: heitorpolidoro/auto-release@v0
        with:
          personal_access_token: ${{ secrets.PAT }}
          allowed_users: heitorpolidoro
          version_file: version.txt
```
