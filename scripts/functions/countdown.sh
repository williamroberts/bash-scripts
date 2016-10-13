#!/usr/bin/env bash

function countdown() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will display how long is left until a given date in a given format";
    echo "Arguments:";
    echo "";
    echo "    -d, --date          The date to which you want to know the interval";
    echo "    -f, --format        The format of the output (Valid formats are the same as the built in 'date' function. Defaults to '+%B %d, %Y' (e.g. February 18, 1986). For more information, type 'date --help'";
    echo "";
    return 0;
  fi;

  __countdown__init && \
    __countdown__parseArgs "$@" && \
    __countdown__validateArgs && \
    __countdown__process;
}

function __countdown__init() {
  unset __countdown_DATE;
  __countdown_FORMAT="+%B %d, %Y";
}

function __countdown__parseArgs() {
  for i in "$@";
  do
    case $i in
      -d=*|--date=*)
        __countdown_DATE="${i#*=}";
        shift;;
      -f=*|--format=*)
        __countdown_FORMAT="${i#*=}";
        shift;;
    esac
  done;
}

function __countdown__validateArgs() {
  date "$__countdown_FORMAT" -d "$__countdown_DATE" > /dev/null 2>&1;
  if [ $? -ne 0 ];
  then
    echo "ERROR: Could not parse given date with given format";
    echo "Not all args set correctly. Exiting...";
    return 1;
  fi
}

function __countdown__process() {
  SPACER='                   ';
  FORMATTED_DATE="$(date --date="$__countdown_DATE" "$__countdown_FORMAT")";
  TODAYS_DATE="$(date +%y%m%d)";
  DIFF_IN_SECS="$(( $(date --date="$__countdown_DATE" +%s) - $(date --date="$TODAYS_DATE" +%s) ))";
  DIFF_IN_DAYS="$(( (DIFF_IN_SECS/(60*60*24)) + 1 ))";
  printf "%s%s: %s weeks and %s days (%s total days)\n" "$FORMATTED_DATE" "${SPACER:${#FORMATTED_DATE}}" "$(( DIFF_IN_DAYS/7 ))" "$(( DIFF_IN_DAYS%7 ))" "$DIFF_IN_DAYS";
}
