#!/bin/bash

for pluginFolder in `ls -1 ~/.vim/bundle`
do
    /usr/bin/git --git-dir=${HOME}/.vim/bundle/${pluginFolder}/.git \
                 --work-tree=${HOME}/.vim/bundle/${pluginFolder} \
                 pull origin master
done
