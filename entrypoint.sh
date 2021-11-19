#!/bin/bash
remove_release()
{
  set -x
   git tag -d $1
   git push --delete origin $1
   gh release delete $1 -y
}

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
    git fetch --prune --unshallow --tags --quiet
    LAST_RELEASE=$(git tag --sort=v:refname | sort | tail -1)
    if [[ -n "$LAST_RELEASE" ]]
    then
      echo "Last Release: $LAST_RELEASE"
      if [[ -n $(git tag --list "v$NEW_RELEASE") ]]
      then
        >&2 echo -e "Version$BOLD v$NEW_RELEASE$NORMAL already exists"
        exit 1
      fi
    fi

  gh release create "v$NEW_RELEASE"
  echo "::endgroup::"
  if [[ "$INPUT_UPDATE_RELEASED_VERSIONS" == "true" ]]
  then
    IFS=. read -r -a array <<< "$NEW_RELEASE"
    vX="v${array[0]}"
    vXY=$(IFS=. ;echo "v${array[*]:0:2}")

    if [[ -n $(git tag --list "$vX") ]]
    then
      echo "::group::Updating version $vX"
      remove_release $vX
    else
      echo "::group::Creating version $vX"
    fi
    gh release create "$vX"

    if [[ -n $(git tag --list "$vXY") ]]
    then
      echo "::group::Updating version $vXY"
      remove_release $vXY
    else
      echo "::group::Creating version $vXY"
    fi
    fi
    gh release create "$vXY"
  fi
fi
