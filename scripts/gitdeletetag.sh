#!/usr/bin/env bash

function gitdeletetag() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will delete the given tag locally and on the remote repository";
    echo "Arguments:";
    echo "";
    echo "    -g, --git-directory (optional)    The path to the file or folder whose line count you want. Defaults to current directory.";
    echo "    -t, --tag                         The tag you wish to delete.";
    echo "    -f, --force (optional)            Don't prompt for confirmation";
    echo "";
    return 0;
  fi;

  __gitdeletetag__init && \
    __gitdeletetag__parseArgs "$@" && \
    __gitdeletetag__validateArgs && \
    __gitdeletetag__process;
}

function __gitdeletetag__init() {
  __gitdeletetag_DIRECTORY=$(pwd);
  unset __gitdeletetag_TAG;
  __gitdeletetag_FORCE=false;
}

function __gitdeletetag__parseArgs() {
  for i in "$@";
  do
    case $i in
      -g=*|--git-directory=*)
        __gitdeletetag_DIRECTORY="${i#*=}";
        shift;;
      -t=*|--tag=*)
        __gitdeletetag_TAG="${i#*=}";
        shift;;
      -f=*|--force*)
        __gitdeletetag_FORCE=true;
        shift;;
    esac
  done;
}

function __gitdeletetag__validateArgs() {
  if [ -z "$__gitdeletetag_DIRECTORY" ];
  then
    return 1;
  fi;
  if [ ! -d "$__gitdeletetag_DIRECTORY/.git" ];
  then
    echo "ERROR: The given directory is not a git repository";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi;
  git --git-dir="$__gitdeletetag_DIRECTORY/.git" rev-parse "$__gitdeletetag_TAG" >/dev/null 2>&1;
  if [ $? -ne 0 ];
  then
    echo "ERROR: The given tag doesn't exist: $__gitdeletetag_TAG";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __gitdeletetag__process() {
  if [ "$__gitdeletetag_FORCE" = false ];
  then
    read -p "This will permanently remove the tag: $__gitdeletetag_TAG. Continue? (y/N) " response
    case "$response" in
      [yY]|[yY][eE][sS])
        echo "Confirmed";;
      *)
        echo "Aborting...";
        return 1;;
    esac;
  fi;
  $3
  echo "Tag removed: $__gitdeletetag_TAG";
}
