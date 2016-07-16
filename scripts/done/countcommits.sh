#!/usr/bin/env bash

function countcommits() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will count the number of commits in the given directory for the given author";
    echo "Arguments:";
    echo "";
    echo "    -d, --directory        The path to the directory holding the Git repository to query. Defaults to current directory";
    echo "    -a, --author           The author whose commits to count";
    echo "";
    return 0;
  fi;

  __countcommits__init && \
    __countcommits__parseArgs "$@" && \
    __countcommits__validateArgs && \
    __countcommits__process;
}

function __countcommits__init() {
  __countcommits_DIRECTORY=".";
}

function __countcommits__parseArgs() {
  for i in "$@";
  do
    case $i in
      -d=*|--directory=*)
        __countcommits_DIRECTORY="${i#*=}";
        shift;;
      -a=*|--author=*)
        __countcommits_AUTHOR="${i#*=}";
        shift;;
    esac
  done;
}

function __countcommits__validateArgs() {
  if [ ! -d "$__countcommits_DIRECTORY" ];
  then
    echo "ERROR: Can't find directory: $__countcommits_DIRECTORY";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
  if [ ! -d "$__countcommits_DIRECTORY/.git" ];
  then
    echo "ERROR: Directory $__countcommits_DIRECTORY is not a git repository."
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __countcommits__process() {
  git --git-dir="$__countcommits_DIRECTORY"/.git shortlog -s -n --all --no-merges --author="$__countcommits_AUTHOR"
}
