#!/bin/bash
remove_release()
{
  set -x
  git tag -d $1
  git push --delete origin $1
  gh release delete $1 -y
}

set -e
gh auth status
echo "::group::Creating Release v$NEW_RELEASE"
NEW_RELEASE=$(cat "$INPUT_VERSION_FILE")
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
  echo "::endgroup::"

  if [[ -n $(git tag --list "$vXY") ]]
  then
    echo "::group::Updating version $vXY"
    remove_release $vXY
  else
    echo "::group::Creating version $vXY"
  fi
  gh release create "$vXY"
  echo "::endgroup::"
fi
