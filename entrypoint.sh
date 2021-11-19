#!/bin/bash
BOLD='\x1b[1m'
NORMAL="\x1b[0m"
set -e
if [[ -n "$INPUT_ALLOWED_USERS" ]] && [[ ! " ${INPUT_ALLOWED_USERS[*]} " =~ " ${GITHUB_ACTOR} " ]]
then
  echo -e "User $BOLD$GITHUB_ACTOR$NORMAL is not allowed to auto-release"
else
  echo "::group::GitHub authentication"
    echo "$INPUT_PERSONAL_ACCESS_TOKEN" | gh auth login --with-token
  echo "::endgroup::"

  NEW_RELEASE=$(cat "$INPUT_VERSION_FILE")
  echo "::group::Creating Release v$NEW_RELEASE"
    git fetch --prune --tags --quiet
#    git fetch --prune --unshallow --tags --quiet
    LAST_RELEASE=$(git tag --list | sort | tail -1)
    if [[ -n "$LAST_RELEASE" ]]
    then
      echo "Last Release: $LAST_RELEASE"
      if [[ "$LAST_RELEASE" == "v$NEW_RELEASE" ]]
      then
        >&2 echo -e "Version$BOLD v$NEW_RELEASE$NORMAL already exists"
        exit 1
      fi
    fi

    gh release create "v$NEW_RELEASE"
  echo "::endgroup::"
fi

