#!/usr/bin/env bash

function curlc() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Returns the HTTP response code of a curl request";
    echo "";
    return 0;
  fi;

  curl -k -s -o /dev/null -w "%{http_code}" "$1";
  echo "";
}
