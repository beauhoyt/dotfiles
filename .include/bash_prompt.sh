#!/bin/bash

source ~/bin/colors.sh

# Taken from: https://github.com/jimeh/git-aware-prompt
function build_extra_prompt() {
    local extra_prompt

    # Based on: http://stackoverflow.com/a/13003854/170413
    local branch
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    then
        if [[ "$branch" == "HEAD" ]]
        then
            branch='detached*'
        fi
        extra_prompt="${bldgrn}(${branch})"
    else
        extra_prompt=""
    fi

    # Python Virtual Environments
    local virtual_env
    if [ ! -z "${VIRTUAL_ENV}" ]
    then
        virtual_env=`basename ${VIRTUAL_ENV}`
        extra_prompt="${bldcyn}{${virtual_env}}${extra_prompt}"
    fi

    # Pulumi
    local pulumi_stack
    if $(pwd -P | \grep pulumi > /dev/null 2>&1)
    then
       if pulumi_stack=$(pulumi stack --show-name 2> /dev/null)
       then
           extra_prompt="${extra_prompt}${bldpur}<${pulumi_stack}>"
       fi
    fi

    local prompt
    prompt="${txtwht}[${txtred}\t${txtwht}]"
#    prompt="${prompt}[${bldylw}\u${txtwht}][${bldylw}\w${txtwht}]"
    prompt="${prompt}[${bldylw}\u${txtwht}@${bldpur}\h${txtwht}]"
    prompt="${prompt}[${bldylw}\W${txtwht}]"
    prompt="${prompt}${extra_prompt}${txtwht}\$${txtrst} "

    export PS1="${prompt}"
}
build_extra_prompt
PROMPT_COMMAND=build_extra_prompt
