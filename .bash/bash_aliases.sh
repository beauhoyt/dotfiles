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

        function fixMissionControl() {
            defaults delete com.apple.dock mcx-expose-disabled
            defaults delete com.apple.dock expose-animation-duration
            defaults delete com.apple.dock expose-group-by-app
            defaults delete com.apple.dock expose-grouped
            defaults delete com.apple.dock "expose-last-active-sticky"
            defaults delete com.apple.dock "expose-layout"
            defaults delete com.apple.dock "expose-space-animation-duration"
            defaults delete com.apple.dock "expose-thumbnail-size"
            killall Dock
        }
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
alias svncolor='python3 ~/bin/svn-color.py'
alias svnc='python3 ~/bin/svn-color.py'
alias csvn='python3 ~/bin/svn-color.py'

alias ptree='tree --prune'
alias ltree='tree -L 2'

# Public git repo thats kind of private via obfuscating
alias beauhoyt_sha2='echo -n $(echo -n beauhoyt | shasum -a 256 | cut -c 1-39)'

alias gobo='cd ~/go/src/github.com/beauhoyt'
alias bogo='cd ~/go/src/github.com/beauhoyt'

# Shelling into old Cisco Switches with the correct kex algorithm and cypher
alias sshOldSwitch='ssh -oKexAlgorithms=diffie-hellman-group-exchange-sha1 -c aes128-cbc -A'

removeSshKeyForHost() {
  echo "Cleanup pub keys in ~/.ssh/known_hosts for host: $1"
  ssh-keygen -r $1
  ssh-keygen -R $1
  echo "Re-adding pub keys to ~/.ssh/known_hosts for host: $1"
  ssh-keyscan $1 >> ~/.ssh/known_hosts
  echo "Testing SSH to host: $1"
  ssh -A $1 'hostname'
  if [ $? ]
  then
    echo "Host $1 Test Successful!!"
  else
    echo "Host $1 Test Failed!! :("
  fi
}

removeSshKeyForDeploy() {
  echo "Remove SSH Keys for Host: $2 on $1 server"
  ssh -A $1 '
  hostname ;
  sudo -u deploy -i ssh-keygen -r '$2' ;
  sudo -u deploy -i ssh-keygen -R '$2' ;
  echo "Re-adding pub keys to /home/deploy/.ssh/known_hosts for host: '$2'"
  sudo -u deploy ssh-keyscan '$2' >> /home/deploy/.ssh/known_hosts
  echo "Testing SSH to host: '$2'"
  sudo -u deploy ssh -A '$2' "hostname"
  if [ $? ] ;
  then
    echo "Host '$2' Test Successful through '$1' server!!" ;
  else
    echo "Host '$2' Test Failed through '$1' server!! :((((" ;
  fi ;
  '
}

reloginForDeploy() {
  echo "Re-setting up SSH Keys for Host: $2 on $1 server"
  ssh -t -A $1 '
    hostname ;
    sudo -H -u deploy -i /bin/ssh -t -i .ssh/id_rsa '$2' "hostname"
  '
}

cssh() {
  removeSshKeyForHost $1
  ssh -A $1
}
