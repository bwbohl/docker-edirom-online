#!/usr/bin/env bash
# Script to download asset file from tag release using GitHub API v3.
# Author: https://stackoverflow.com/users/55075/kenorb
# See: http://stackoverflow.com/a/35688093/55075

# echo welcome
echo "#######################################"
echo "# WELCOME TO THE GH-ASSETS DOWNLOADER #"
echo "#######################################"

CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

# Check dependencies.
echo "Checking dependencies…"
echo "----------------------"
set -ea
type awk curl grep sed tr >&2
xargs=$(which gxargs || which xargs)
echo ""

# Validate settings.
[ -f $HOME/.secrets ] && source $HOME/.secrets
[ "$GITHUB_API_TOKEN" ] || { echo "Error: Please define GITHUB_API_TOKEN variable." >&2; exit 1; }
[ $# -ne 4 ] && { echo "Usage: $0 [owner] [repo] [tag] [name]"; exit 22; }
[ "$TRACE" ] && set -x
read owner repo tag name <<<$@

# Define variables.
GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/$owner/$repo"
case $tag in
  release-latest) GH_TAGS="$GH_REPO/releases/latest"
  ;;
  *) GH_TAGS="$GH_REPO/releases/tags/$tag"
  ;;
esac
FORMAT="Accept: application/vnd.github+json"
AUTH="Authorization: Bearer $GITHUB_API_TOKEN"
API_VERSION="X-GitHub-Api-Version: 2022-11-28"
#WGET_ARGS="--content-disposition --auth-no-challenge --no-cookie"
CURL_ARGS="-LJO#"

# Echo variables for debugging.
echo "Variables are…"
echo "--------------"
echo "GH_API:    $GH_API"
echo "GH_REPO:   $GH_REPO"
echo "GH_TAGS:   $GH_TAGS"
echo "AUTH:      $AUTH"
echo "CURL_ARGS: $CURL_ARGS"
echo ""

# Validate token.
echo "Validating GitHub token."
echo "------------------------"
curl -o /dev/null -L -H "$FORMAT" -H "$AUTH" -H "$API_VERSION" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 11; }
echo ""

# Read asset tags.
echo "Reading Asset Tags…"
echo "-------------------"
response=$(curl -L -H "$FORMAT" -H "$AUTH" -H "$API_VERSION" $GH_TAGS)
echo $response
echo ""

# Get ID of the asset based on given name.
echo "Getting ID of asset based on given name…"
echo "-----------------------------------------"
eval $(echo "$response" | grep -C3 "name.:.\+$name" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')
#id=$(echo "$response" | jq --arg name "$name" '.assets[] | select(.name == $name).id') # If jq is installed, this can be used instead.
[ "$id" ] || { echo "Error: Failed to get asset id, response: $response" | awk 'length($0)<100' >&2; exit 3; }
GH_ASSET="$GH_REPO/releases/assets/$id"
echo "$id"
echo ""

# Download asset file.
echo "Downloading asset..."
echo "--------------------"
curl -L -H "$AUTH" -H "Accept: application/octet-stream" -H "$API_VERSION" "$GH_ASSET"
echo "$0 done."
echo ""
