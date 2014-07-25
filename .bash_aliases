#!/bin/bash

osType=`uname`
if [ $osType == "Darwin" -o $osType == "FreeBSD" ]
then
    alias ls='ls -G'
    if [ $osType == "Darwin" ]
    then
        alias dhcp-start='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
        alias dhcp-stop='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'
    fi
elif [ ${osType} == "SunOS" ]
then
    lsLocation='/opt/csw/gnu/ls'
    # Only add alias for GNU ls on Solaris systems
    if [ -f ${lsLocation} ]
    then
        alias ls="${lsLocation} --color=auto"
    fi
else
    alias ls='ls --color=auto'
fi

alias grep='grep -iHn --color=always'
alias less='less -iSFX'
alias vi='vim'

# Color SVN shortcut
alias svncolor='python ~/bin/svn-color.py'
alias svnc='python ~/bin/svn-color.py'
alias csvn='python ~/bin/svn-color.py'

# helps which know about aliases
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
