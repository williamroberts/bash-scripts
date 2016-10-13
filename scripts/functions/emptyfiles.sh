#!/usr/bin/env bash

function emptyfiles() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Lists any files in the given directory and sub-directories that are 0 bytes in size";
    echo "Arguments:";
    echo "";
    echo "    -d, --directory        The path to the directory to search. Defaults to current directory";
    echo "";
    return 0;
  fi;

  __emptyfiles__init && \
    __emptyfiles__parseArgs "$@" && \
    __emptyfiles__validateArgs && \
    __emptyfiles__process;
}

function __emptyfiles__init() {
  __emptyfiles_DIRECTORY=".";
}

function __emptyfiles__parseArgs() {
  for i in "$@";
  do
    case $i in
      -d=*|--directory=*)
        __emptyfiles_DIRECTORY="${i#*=}";
        shift;;
    esac
  done;
}

function __emptyfiles__validateArgs() {
  if [ ! -d "$__emptyfiles_DIRECTORY" ];
  then
    echo "ERROR: Can't find directory: $__emptyfiles_DIRECTORY";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __emptyfiles__process() {
  find "$__emptyfiles_DIRECTORY" -empty -type f;
}
