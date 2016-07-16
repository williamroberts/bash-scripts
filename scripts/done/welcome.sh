#!/usr/bin/env bash

function welcome() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Provides a friendly welcome";
    echo "";
    return 0;
  fi;

  cowthink "It's $(date '+%A %B %d %Y %r')";
  echo '';
  echo "Welcome to week number: $(howlongw) (Day: $(howlong))";
  echo '';
}
