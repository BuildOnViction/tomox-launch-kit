#!/usr/bin/env bash
#
# Build tomox-sdk-ui development container

readonly CURRENT_SCRIPT="$(basename -- ${BASH_SOURCE[0]})"
readonly CURRENT_DIRECTORY="$(cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly DOCKER_BINARY="$(command -v docker)"
readonly GITHUB_URL="https://github.com/tomochain/tomox-launch-kit.git"

source "${CURRENT_DIRECTORY}/scripts/config.sh"
source "${CURRENT_DIRECTORY}/scripts/util.sh"

COINBASE_ADDRESS=$2
RELAYER_REGISTRATION_CONTRACT_ADDRESS=$3

# usage: usage [printer]
usage() {
  local printer="$(arg_or_default "$1" 'print_raw')"

  "${printer}" "usage: ${CURRENT_SCRIPT} [-h] [TAG] [COINBASE ADD] [CONTRACT ADD]"
}

# usage: full_usage [printer]
full_usage() {
  local printer="$(arg_or_default "$1" 'print_raw')"

  usage "${printer}"
  "${printer}"
  "${printer}" 'Build tool for tomox-sdk-ui development container'
  "${printer}"
  "${printer}" 'arguments:'
  "${printer}" '  -h                    show this help message and exit'
  "${printer}" '  TAG                   the tag of the image to build'
  "${printer}" '  COINBASE ADD          the coin base address for relayer'
  "${printer}" '  CONTRACT ADD          the contract address for relayer'  
}


# usage: build_image [tag]
build_image() {
  # Pull the lastest tomox-sdk-ui to current directory
  git pull ${GITHUB_URL} -o tomox-sdk-ui 
  # Generate image name
  local name="${DOCKER_IMAGE_NAME}:$(arg_or_default "$1" \
                                                    "${DOCKER_IMAGE_TAG}")"

  print "building image ${name}"

  # Run docker with the provided arguments
  docker build -t "${name}" \
                  "${CURRENT_DIRECTORY}/${DOCKER_LOCAL_SOURCE_DIRECTORY}"
}

# usage: main [-h] [-d DATA_DIRECTORY] [-t TAG] [ARGS...]
main() {
  check_requirements "$@" || exit 1

  while getopts ':h' OPT; do
    case "${OPT}" in
      h)
        full_usage
        exit 0
        ;;
      ?)
        full_usage
        print
        error "invalid argument: ${OPTARG}"
        exit 1
        ;;
    esac
  done

  shift $((OPTIND - 1))

  build_image "$@"
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  main "$@"
fi
