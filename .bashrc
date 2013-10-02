#!/bin/bash
# Taken from: https://github.com/mbrochh/mbrochh-dotfiles

# If not running interactively, don't do anything
if [[ $- != *i* ]]
then
    return
fi

# Include all other bash_* files
for fileIncludes in ~/.{bash_history_config,bash_aliases,bash_prompt,bash_exports}
do
    if [ -r $fileIncludes ]
    then
        source $fileIncludes
    fi
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ `uname` = 'Darwin' ]; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
else
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
