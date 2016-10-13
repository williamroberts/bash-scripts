#!/usr/bin/env bash

function capitalisefirstletter() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Capitalises the first letter of the first input string. Ignores subsequent input.";
    echo "";
    return 0;
  fi;

  echo "${1^}";
}
