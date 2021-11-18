#!/bin/bash
set -e
pwd
ls -a /github/workspace/.github
ls -a /github/home
ls -a /github

sleep 10
echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
echo "::endgroup::"

echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

