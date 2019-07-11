#!/usr/bin/env bash
#
# Utilities for tomox-sdk-ui development container scripts

# usage: print [args...]
print() {
  echo "${CURRENT_SCRIPT}: $*"
}

# usage: print_raw [args...]
print_raw() {
  echo "$*"
}

# usage: error [args...]
error() {
  print "error: $*" >&2
}

# usage: error_raw [args...]
error_raw() {
  print_raw "$*" >&2
}

# usage: check_requirements
check_requirements() {
  if [[ -z "${CURRENT_SCRIPT}" ]]; then
    error "CURRENT_SCRIPT not set"
    exit 1
  fi

  if [[ -z "${CURRENT_DIRECTORY}" ]]; then
    error "CURRENT_DIRECTORY not set"
    exit 1
  fi

  if [[ -z "${DOCKER_BINARY}" ]]; then
    error "unable to find docker (DOCKER_BINARY not set)"
    return 1
  fi
}

# usage: docker [args...]
docker() {
  "${DOCKER_BINARY}" "$@"

  local exit_code="$?"

  if [[ "${exit_code}" -ne 0 ]]; then
    error "${DOCKER_BINARY} exited with code ${exit_code}"
    return 1
  fi
}

# usage: arg_or_default arg default [new arg value]
arg_or_default() {
  if [[ -n "$1" ]]; then
    if [[ "$#" -eq 3 ]]; then
      echo "$3"
    else
      echo "$1"
    fi
  else
    echo "$2"
  fi
}