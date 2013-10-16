#!/bin/bash

osType=`uname`
if [ $osType == "Darwin" -o $osType == "FreeBSD" ]
then
    alias ls='ls -G'
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
