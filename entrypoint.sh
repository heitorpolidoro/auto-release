#!/bin/bash
set -e
pwd
ls -a
cd ..
pwd
ls -a
cd ..
pwd
ls -a

sleep 10
echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
echo "::endgroup::"

echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

