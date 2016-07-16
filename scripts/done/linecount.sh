#!/usr/bin/env bash

function linecount() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Counts the lines in a single file, or all files in a directory";
    echo "Arguments:";
    echo "";
    echo "    -p, --path        The path to the file or folder whose line count you want. Defaults to current directory.";
    echo "";
    return 0;
  fi;

  __linecount__init && \
    __linecount__parseArgs "$@" && \
    __linecount__validateArgs && \
    __linecount__processFile "$__linecount_PATH" && \
    __linecount__processDir "$__linecount_PATH";
}

function __linecount__init() {
  __linecount_PATH=".";
}

function __linecount__parseArgs() {
  for i in "$@";
  do
    case $i in
      -p=*|--path=*)
        __linecount_PATH="${i#*=}";
        shift;;
    esac
  done;
}

function __linecount__validateArgs() {
  if [ ! -d "$__linecount_PATH" ] && [ ! -f "$__linecount_PATH" ];
  then
    echo "ERROR: Provided path is neither a file nor a directory (so it probably doesn't exist)";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __linecount__processFile() {
  if [ -f "$__linecount_PATH" ];
  then
    printf "File: %s %s\n" "$1" "$(wc -l < "$1")";
  fi;
}

function __linecount__processDir() {
  if [ -d "$1" ];
  then
    (
      for i in $(find $1 -type f);
      do
        printf "File: %s %s\n" "$i" "$(wc -l < "$i")";
      done
    ) | sort -k3;
  fi;
}
