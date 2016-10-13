#!/usr/bin/env bash

function timecmd() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will time any command passed to it in nanoseconds";
    echo "Usage:";
    echo "";
    echo "    timecmd <command>, e.g. timecmd echo hello world"
    echo "";
    return 0;
  fi;

  __timecmd__validateArgs "$@" && \
    __timecmd__process "$@";
}

function __timecmd__validateArgs() {
  __timecmd_ARGS="$*"
  if [ -z "$__timecmd_ARGS" ];
  then
    echo "ERROR: No command found";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __timecmd__process() {
  START=$(date +%s%N);
  "$@";
  END=$(date +%s%N);
  DIFF=$(( END-START ));
  printf "%s seconds\n" "$(echo "$DIFF" | sed "s/.........$/.&/")";
}
