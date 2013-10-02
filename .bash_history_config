#!/bin/bash

# Time formating of history
# Example:
#   3  2013-07-25 19:02:39 exit
#   4  2013-07-25 19:02:39 cat /etc/redhat-release
export HISTTIMEFORMAT='%F %T '

# Size of history
export HISTSIZE=10000
export HISTFILESIZE=10000

# Remove duplicates only if they are consecutive commands
export HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend
