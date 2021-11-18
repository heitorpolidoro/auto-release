#!/bin/bash
echo "::group::Create Release"
set -e
git status
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
gh auth status
echo "Estou no entrypoint"
echo "::endgroup::"

