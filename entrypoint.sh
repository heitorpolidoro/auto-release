#!/bin/bash
set -e
echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL-ACCESS-TOKEN" | gh auth login --with-token
gh auth status
echo "::endgroup::"

echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

