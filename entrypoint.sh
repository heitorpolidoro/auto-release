#!/bin/bash
set -e

sleep 10
echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
echo "::endgroup::"
set -x
pwd
ls -a /github/workspace/.github
ls -a /github/home
ls -a /github
echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

