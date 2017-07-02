#!/bin/bash

# Add once to $PATH
pathadd() {
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$1($|:)"
    then
        if [ "$2" = "after" ]
        then
            export PATH="${PATH}:${1%/}"
        else
            export PATH="${1%/}:${PATH}"
        fi
    fi
}

# Remove from $PATH
pathrm() {
    export PATH="$(echo ${PATH} | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

# Xterm support
if [ -n "${DISPLAY}" -a "${TERM}" = "xterm" ]
then
    export TERM="xterm-256color"
# Solaris
elif [ ${osType} == "SunOS" ]
then
    export TERM="xterm"
fi

# Rust lang path
pathadd "${HOME}/.cargo/bin" "after"

# GO lang path
export GOPATH="${HOME}/go"
pathadd "${GOPATH}/bin" "after"

if [ ${osType} == "Darwin" ]
then
    # Homebrew Github API Token for higher ratelimit on brew commands
    if [ -e "${HOME}/.bash_exports_homebrew_github_api_token" ]
    then
        source ${HOME}/.bash_exports_homebrew_github_api_token
    fi

    # MacVim
    if [ -d "/Applications" ]
    then
        export VIM_APP_DIR="/Applications"
    fi

    pathadd "/usr/local/opt/go/libexec/bin" "after"
else
    pathadd "/usr/local/go/bin" "after"
fi

# Setup PyENV
if which pyenv > /dev/null
then
    if [ -z "$(echo $PATH | grep '\.pyenv')" ]
    then
        eval "$(pyenv init -)"
    fi
fi
# Setup PyENV plugin VirtualENV
if which pyenv-virtualenv-init > /dev/null
then
    if [ -z "$(echo $PATH | grep 'pyenv-virtualenv')" ]
    then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# LS colors
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:"
