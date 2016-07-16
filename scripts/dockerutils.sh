#!/usr/bin/env bash

alias docklog='sudo docker logs -f $(sudo docker ps -aq -n=1)';
alias dockbash='sudo docker exec -it $(sudo docker ps -aq -n=1) bash';
alias dockthis='sudo docker build -t img-${PWD##*/} . && sudo docker run -d --name=con-${PWD##*/} img-${PWD##*/}';
alias undockthis='sudo docker rm -f con-${PWD##*/} && sudo docker rmi img-${PWD##*/}';
