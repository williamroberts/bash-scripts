#!/usr/bin/env bash

function gitage() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ];
  then
    echo "";
    echo "Name:           $FUNCNAME";
    echo "Description:    Will list the branches of the current git repository in order of age";
    echo "";
    return 0;
  fi;

  for ref in $(git for-each-ref --sort=-committerdate --format="%(refname)" refs/remotes/ );
  do
      git log -n1 $ref --pretty=format:"%Cgreen%cr%Creset %C(yellow)%d%Creset %C(bold blue)<%an>%Creset%n" | cat;
  done;
}
