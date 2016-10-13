#!/usr/bin/env bash

#TODO: Conditional sudo - i.e. only sudo if NOT root
bash init_bashrc.sh && \
    bash install_tools.sh && \
    bash install_functions.sh && \
    bash install_aliases.sh && \
    bash complete_bashrc.sh;
