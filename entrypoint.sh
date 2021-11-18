#!/bin/bash
set -e

echo "::group::GitHub authentication"
echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
GITHUB_USER=$(gh auth status 2>&1 | grep Logged | sed 's/.* as \(.*\) (.*/\1/')
echo "Logged as $GITHUB_USER"
echo "::endgroup::"

if [[ -n "$INPUT_ALLOWED_USERS" ]] && [[ ! " ${INPUT_ALLOWED_USERS[*]} " =~ " ${GITHUB_USER} " ]]
then
  echo 1
fi
echo "::group::Create Release"
echo "Estou no entrypoint"
echo "::endgroup::"

