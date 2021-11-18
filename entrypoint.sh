#!/bin/bash
set -e

sleep 10
echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
echo "::endgroup::"
set -x
pwd
ls -a /github/home
cat /github/home/.config/gh/hosts.yml
echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

