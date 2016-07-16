#!/usr/bin/env bash

function infinite() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Runs a command repeatedly forever with a given interval";
		echo "Arguments:";
		echo "";
		echo "    -i, --interval        The interval between executions of the command";
		echo "    -c, --command         The command to run repeatedly forever"
		echo "";
    return 0;
  fi;

	__infinite__parseArgs "$@" && \
  	__infinite__validateArgs && \
    __infinite__process;
}

function __infinite__parseArgs() {
  for i in "$@";
  do
    case $i in
      -i=*|--interval=*)
        __infinite_INTERVAL="${i#*=}";
        shift;;
			-c=*|--command=*)
        __infinite_COMMAND="${i#*=}";
        shift;;
    esac
  done;
}

function __infinite__validateArgs() {
	case "$__infinite_INTERVAL" in
		''|*[!0-9]*)
			echo "ERROR: Provided interval is not a number.";
			echo "Not all args set correctly. Exiting...";
			return 1;
			;;
	esac
}

function __infinite__process() {
	while true;
	do
		$__infinite_COMMAND;
		sleep "$__infinite_INTERVAL";
	done;
}
