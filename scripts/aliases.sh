#!/usr/bin/env bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)";
    alias ls='ls --color=auto';
    alias dir='dir --color=auto';
    alias vdir='vdir --color=auto';
    alias grep='grep --color=auto';
    alias fgrep='fgrep --color=auto';
    alias egrep='egrep --color=auto';
fi;

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"';

# Misc aliases
alias src='source ~/.bashrc';
alias edbash='vi ~/.bashrc';

# Git aliases
alias gitagef='SAVEIFS=$IFS; IFS=$(echo -en "\n\b"); for i in $(find . -type f -not -path "**/.git/*"); do echo "$(git log -1 --format="%ci" $i) $i"; done | sort -n; IFS=$SAVEIFS'

# Docker aliases
alias docklog='sudo docker logs -f $(sudo docker ps -aq -n=1)';
alias dockbash='sudo docker exec -it $(sudo docker ps -aq -n=1) bash';
alias dockthis='sudo docker build -t img-${PWD##*/} . && sudo docker run -d --name=con-${PWD##*/} img-${PWD##*/}';
alias undockthis='sudo docker rm -f con-${PWD##*/} && sudo docker rmi img-${PWD##*/}';

# Date aliases
alias howlong="echo "$(( ($(date +%s) - $(date --date="140727" +%s) )/(60*60*24) ))""
