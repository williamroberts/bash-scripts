#!/usr/bin/env bash

function netchange() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will calculate the net line change in the given directory for the given author";
    echo "Arguments:";
    echo "";
    echo "    -d, --directory (required)    The path to the directory holding the Git repository to query";
    echo "    -a, --author (optional)       The author whose commits to count";
    echo "";
    return 0;
  fi;

  __netchange__parseArgs "$@" && \
    __netchange__validateArgs && \
    __netchange__process;
}

function __netchange__parseArgs() {
  for i in "$@";
  do
    case $i in
      -d=*|--directory=*)
        __netchange__DIRECTORY="${i#*=}";
        shift;;
      -a=*|--author=*)
        __netchange_AUTHOR="${i#*=}";
        shift;;
    esac
  done;
}

function __netchange__validateArgs() {
  if [ ! -d "$__netchange__DIRECTORY" ];
  then
    echo "ERROR: Can't find directory: $__netchange__DIRECTORY";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __netchange__process() {
  SAVEIFS=$IFS;
  IFS=$(echo -en "\n\b");
  for i in $(git --git-dir="$__netchange__DIRECTORY"/.git log --author="$__netchange_AUTHOR" --format='%aN' | sort -u);
  do
      echo "";
      echo "$i";
      git --git-dir="$__netchange__DIRECTORY"/.git log --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, net change: %s\n", add, subs, loc }' -;
  done;
  IFS=$SAVEIFS
}
