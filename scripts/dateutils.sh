#!/usr/bin/env bash

alias howlong="echo "$(( ($(date +%s) - $(date --date="140727" +%s) )/(60*60*24) ))""
alias howlongw="echo "$(( ($(date +%s) - $(date --date="140727" +%s) )/(60*60*24)/7 ))""

formatnanoseconds

function countdowner() {
    while true; do
        DDAY="$1";
        printf "\n%s  ---  %s  ---  %s  ---  %s  ---  %s" "$(( ( $(date --date="$DDAY" +%s) - $(date +%s) ) / 60 / 60 / 24 / 7 )) weeks" "$(( ( $(date --date="$DDAY" +%s) - $(date +%s) ) / 60 / 60 / 24  )) days" "$(( ( $(date --date="$DDAY" +%s) - $(date +%s) ) / 60 / 60 )) hours" "$(( ( $(date --date="$DDAY" +%s) - $(date +%s) ) / 60 )) minutes" "$(( ( $(date --date="$DDAY" +%s) - $(date +%s) ) )) seconds";
        sleep 1;
    done
}
