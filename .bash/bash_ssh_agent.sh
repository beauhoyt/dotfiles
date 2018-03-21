#!/bin/bash
# Fix ssh-agent 6.9+ to work on OSX
# So you can use ed25519 and ecdsa

# File to hold existing SSH agent sesssion
SSH_ENV="${HOME}/.ssh/environment"
SSH_TMP="/tmp/ssh-agent-$(whoami)"
SSH_TMP_ADD="/tmp/ssh-agent-add-$(whoami)"

SSH_AGENT_BIN="/usr/bin/ssh-agent"
SSH_ADD_BIN="/usr/bin/ssh-add"

if [ -e "/usr/local/bin/ssh-agent" ]
then
  SSH_AGENT_BIN="/usr/local/bin/ssh-agent"
fi
if [ -e "/usr/local/bin/ssh-add" ]
then
  SSH_ADD_BIN="/usr/local/bin/ssh-add"
fi

function start_ssh_agent {

  echo "Initializing new SSH agent..."
  $SSH_AGENT_BIN -s | sed 's/^echo/#echo/' > ${SSH_ENV}
  chmod 0600 ${SSH_ENV}
  source ${SSH_ENV} > /dev/null
  echo "DONE Initializing..."
  echo ""
  echo "Adding Keys..."
  $SSH_ADD_BIN &&
  touch $SSH_TMP_ADD
}

function start_or_recover {

  # Recover existing SSH agent session
  if [ -f "${SSH_ENV}" ]
  then
    source "${SSH_ENV}" > /dev/null

    # Restart SSH agent if it has crashed
    ps -ef | grep "${SSH_AGENT_PID}" | grep "ssh-agent" > /dev/null || {
      start_ssh_agent
    }

    # Check if SSH Agent started up correctly and is useable
    ssh-add -L > /dev/null 2>&1
    if [ "$(echo $?)" != "0" ]
    then
      echo "Looks start_ssh_agent failed to correctly startup"
      echo "Cleaning up all ssh-agent. Please type SUDO Passwd:"
      sudo killall ssh-agent
      echo "DONE Kill all ssh-agents"
      start_ssh_agent
    fi

  # Start SSH agent for the first time
  else
    start_ssh_agent
  fi
}

osType=$(uname)

# Handle for only OSX (Darwin) for now. This should only be called if it's a
# TTY; not PTS (pseudo TTY) or STY (pseudo screen TTY). Meaning it can't be a
# SSH session; it has to be a physical login.
if [ -z "${SSH_TTY}" ] && [ $osType == "Darwin" -o $osType == "Linux" ]
then

  # Create SSH_TMP lock
  if ( set -o noclobber; test ! -e ${SSH_TMP} && echo $$ > ${SSH_TMP} ) 2> /dev/null
  then

      start_or_recover

  else
    if [ -e ${SSH_TMP_ADD} ]
    then
      # Nothing to wait for... just do it
      start_or_recover
    else
      # Wait for SSH keys to be added
      echo "Waiting for ${SSH_TMP_ADD} to be created..."
      while [ ! -e ${SSH_TMP_ADD} ]
      do
        sleep 5
      done

      echo "${SSH_TMP_ADD} was touched..."
      start_or_recover
    fi
  fi

fi
