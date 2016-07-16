#!/usr/bin/env bash

function gitage() {
    for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/remotes/ );
    do
        git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat;
    done
}

function deltag() {
    git tag -d "$1";
    git push origin :refs/tags/"$1"
}

alias gitagef='SAVEIFS=$IFS; IFS=$(echo -en "\n\b"); for i in $(find . -type f -not -path "**/.git/*"); do echo "$(git log -1 --format="%ci" $i) $i"; done | sort -n; IFS=$SAVEIFS'
