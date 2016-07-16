#!/usr/bin/env bash

function killdocker() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will remove docker containers and/or images";
    echo "Arguments:";
    echo "";
    echo "    -c, --containers (optional)    Remove all Docker containers";
    echo "    -i, --images (optional)        Remove all Docker images";
    echo "    -f, --force (optional)         Don't prompt for confirmation";
    echo "";
    return 0;
  fi;

  __killdocker__init && \
    __killdocker__parseArgs "$@" && \
    __killdocker__validateArgs && \
    __killdocker__process "$__killdocker_CONTAINERS" "containers" __killdocker__rmContainers && \
    __killdocker__process "$__killdocker_IMAGES" "images" __killdocker__rmImages;
}

function __killdocker__init() {
  unset __killdocker_CONTAINERS;
  unset __killdocker_IMAGES;
  unset __killdocker_FORCE;
}

function __killdocker__parseArgs() {
  for i in "$@";
  do
    case $i in
      -c|--containers*)
        __killdocker_CONTAINERS=true;
        shift;;
      -i|--images*)
        __killdocker_IMAGES=true;
        shift;;
      -f|--force*)
        __killdocker_FORCE=true;
        shift;;
    esac
  done;
}

function __killdocker__validateArgs() {
  if [ "$__killdocker_CONTAINERS" = false ] && [ "$__killdocker_IMAGES" = false ];
  then
    echo "ERROR: Containers and Images cannot both be false, because then this script wouldn't do anything!!";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __killdocker__process() {
  if [ "$1" = true ];
  then
    if [ "$__killdocker_FORCE" = false ];
    then
      read -p "You have selected to remove all $2. Continue? (y/N) " response
      case "$response" in
        [yY]|[yY][eE][sS])
          echo "Continuing...";
          echo "";;
        *)
          echo "Aborting...";
          echo "";
          return 1;;
      esac;
    fi;
    $3
    echo "All Docker $2 have been removed"
  fi;
}

function __killdocker__rmImages() {
  docker rmi -f "$(docker images -aq)";
}

function __killdocker__rmContainers() {
  docker stop "$(docker ps -a -q)";
  docker rm -f "$(docker ps -a -q)";
}
