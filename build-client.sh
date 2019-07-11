#!/bin/bash

set -e

git_url='https://github.com/tomochain/tomox-sdk-ui.git'
data_url='./tomox-sdk-ui'

DISTROS=(
  mainnet
  testnet
  devnet
)


# test to see if data has been downloaded
# if not, then download it and tell the user about it
if ! [[ -d "data_url" ]]; then
  echo '-------------------'
  echo "First-time clone process..."
  echo "...Downloading from $git_url"

  echo "Done git clone tomox-sdk-ui!"
  echo "-------------------"
fi

function version_gt() {
  if [[ -f /bin/busybox ]] ; then
    test "$(echo "$@" | tr " " "\n" | busybox sort -t '.' -g | tail -n 1)" == "$1"
  else
    test "$(echo "$@" | tr " " "\n" | sort -V | tail -n 1)" == "$1"
  fi
}

function build_image() {
  docker build https://github.com/tomochain/tomox-sdk-ui.git
}

function tag_image {
  local image_group=$1
  local image_name=$2
  local tag=$3
  docker tag tomochain/tomox-sdk-ui:latest ${image_group}/${image_name}:${tag}
}
### Draft ### Move to branch features/dynamic-build-ui

