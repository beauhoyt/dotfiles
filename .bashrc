#!/bin/bash
# Taken from: https://github.com/mbrochh/mbrochh-dotfiles

# If not running interactively, don't do anything
if [[ $- != *i* ]]
then
    return
fi

# Source in extra aliases
for i in ~/.bash/*.sh; do
    if [ -r "$i" ]; then
        if [ "$PS1" ]; then
            source "$i"
        else
            source "$i" >/dev/null 2>&1
        fi
    fi
done
unset i

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ `uname` = 'Darwin' ]; then
    # This code chuck might not be needed anymore with:
    #  brew install bash-completion
    # if [ -f `brew --prefix`/etc/bash_completion ]; then
    #     source `brew --prefix`/etc/bash_completion
    # fi
    # if [ -d `brew --prefix`/etc/bash_completion.d ]; then
    #     for i in $(ls -1 `brew --prefix`/etc/bash_completion.d); do
    #         source `brew --prefix`/etc/bash_completion.d/${i}
    #     done
    # fi
    # Run /usr/local/etc/profile.d/bash_completion.sh
    if [ -r /usr/local/etc/profile.d/bash_completion.sh ]
    then
        source /usr/local/etc/profile.d/bash_completion.sh > /dev/null 2>&1
    fi
else
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        source /etc/bash_completion
    fi
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f ${HOME}/google-cloud-sdk/path.bash.inc ]; then
  source ${HOME}/google-cloud-sdk/path.bash.inc
fi

# The next line enables shell command completion for gcloud.
if [ -f ${HOME}/google-cloud-sdk/completion.bash.inc ]; then
  source ${HOME}/google-cloud-sdk/completion.bash.inc
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
