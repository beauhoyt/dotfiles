#!/bin/bash

osType=$(uname)
# FreeBSD / Darwin / OSX
if [ $osType == "Darwin" -o $osType == "FreeBSD" ]
then
    # LS color
    alias ls='ls -G'

    if [ $osType == "Darwin" ]
    then
        # Helps with reloading DHCP on OSX
        alias dhcp-start='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
        alias dhcp-stop='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'

        # OSX version of which doesn't support as many options as Linux
        alias which='/usr/bin/which -a'

        # OSX version of ncal
        alias cal='ncal -wy'

        # OSX alias helpers similar to linux netstat tool
        alias openTcpPorts='sudo lsof -i -n -P | \grep TCP'
        alias openUdpPorts='sudo lsof -i -n -P | \grep UDP'
        alias listenTcpPort='sudo lsof -iTCP -sTCP:LISTEN -n -P'
        alias osxDNS='scutil --dns'
        alias osxRoutes='netstat -nr'

        # OSX helper for updating Builder mount
        alias updateBuilderMnt='for folder in $(ls -d /Volumes/Builder/*); do svn up $folder; done'

        # OSX toggle Hidden files in Finder, because it's no longer an option
        # inside Finder Preferences.
        alias toggleHiddenFiles='case "$(/usr/bin/defaults read com.apple.finder AppleShowAllFiles)" in
            NO)
                /usr/bin/defaults write com.apple.finder AppleShowAllFiles YES &&
                /bin/echo "Hidden Files Will Show In Finder"
                ;;
            YES)
                /usr/bin/defaults write com.apple.finder AppleShowAllFiles NO &&
                /bin/echo "Hidden Files Will NOT Show In Finder"
                ;;
            *)
                /bin/echo "Error: invalid response: $(/usr/bin/defaults read com.apple.finder AppleShowAllFiles)"
                ;;
        esac'
    fi
# Solaris
elif [ ${osType} == "SunOS" ]
then
    lsLocation='/opt/csw/gnu/ls'
    # Only add alias for GNU ls on Solaris systems
    if [ -f ${lsLocation} ]
    then
        # LS color
        alias ls="${lsLocation} --color=auto"
    fi
# Linux
else
    # LS color
    alias ls='ls --color=auto'

    # helps which know about aliases
    alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
fi

# Case-insensitive, filenames, line numbers, and color highlighting
alias grep='grep -iHn --color=always'
# Nicer less options
alias less='less -iSFX'
# Of course only vim or nvim (once its stable)
alias vi='vim'

# Color SVN shortcut
alias svncolor='python ~/bin/svn-color.py'
alias svnc='python ~/bin/svn-color.py'
alias csvn='python ~/bin/svn-color.py'

alias ptree='tree --prune'
alias ltree='tree -L 2'

# Public git repo thats kind of private via obfuscating
alias beauhoyt_sha2='echo -n $(echo -n beauhoyt | shasum -a 256 | cut -c 1-39)'

alias gobo='cd ~/go/src/github.com/beauhoyt'
