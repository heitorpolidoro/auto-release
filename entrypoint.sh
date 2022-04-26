#!/bin/bash
echo "::group::Workaround"
git config --global --add safe.directory /github/workspace
echo "::endgroup::"

set -e

remove_release()
{
  git tag -d $1
  git push --delete origin $1
  gh release delete $1 -y
}

get_new_release_version()
{
  if [[ "$INPUT_VERSION_FILE" == *__init__.py ]]; then
    if [ -f requirements.txt ]; then pip install -r requirements.txt -q; fi
    module=${INPUT_VERSION_FILE/\/__init__.py/}
    python3 -c "import ${module};print(${module}.VERSION)"
  else
    cat "$INPUT_VERSION_FILE"
  fi
}

if [[ "$(git log -1 --pretty=%B)" == *\[dont-release\]* ]]
then
  echo "Skipping release"
  exit 0
fi

NEW_RELEASE=$(get_new_release_version)
echo "::group::Creating Release v$NEW_RELEASE"
  git fetch --prune --unshallow --tags --quiet
  LAST_RELEASE=$(git tag --sort=v:refname | tail -1)
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
VERSIONS="v$NEW_RELEASE"
echo "::endgroup::"

if [[ "$INPUT_UPDATE_RELEASED_VERSIONS" == "true" ]]
then
  IFS=. read -r -a array <<< "$NEW_RELEASE"
  vX="v${array[0]}"
  vXY=$(IFS=. ;echo "v${array[*]:0:2}")

  if [[ -n $(git tag --list "$vXY") ]]
  then
    echo "::group::Updating version $vXY"
    remove_release $vXY
  else
    echo "::group::Creating version $vXY"
  fi
  gh release create "$vXY"
  VERSIONS="$VERSIONS,$vXY"
  echo "::endgroup::"

  if [[ -n $(git tag --list "$vX") ]]
  then
    echo "::group::Updating version $vX"
    remove_release $vX
  else
    echo "::group::Creating version $vX"
  fi
  gh release create "$vX"
  VERSIONS="$VERSIONS,$vX"
  echo "::endgroup::"
fi
echo "::set-output name=versions::${VERSIONS}"
