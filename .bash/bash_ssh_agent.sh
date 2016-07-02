#!/bin/bash
# Fix ssh-agent 6.9+ to work on OSX
# So you can use ed25519 and ecdsa

# File to hold existing SSH agent sesssion
SSH_ENV="${HOME}/.ssh/environment"

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
  $SSH_AGENT_BIN -s | sed 's/^echo/#echo/' > "${SSH_ENV}"
  chmod 0600 "${SSH_ENV}"
  source "${SSH_ENV}" > /dev/null
  echo "DONE Initializing..."

  echo "Adding Keys..."
  $SSH_ADD_BIN
}

osType=$(uname)

# Handle for only OSX (Darwin) for now. This should only be called if it's a
# TTY; not PTS (pseudo TTY) or STY (pseudo screen TTY). Meaning it can't be a
# SSH session; it has to be a physical login.
if [ -z "${SSH_TTY}" ] && [ $osType == "Darwin" -o $osType == "Linux" ]
then

  # Recover existing SSH agent session
  if [ -f "${SSH_ENV}" ]
  then
    source "${SSH_ENV}" > /dev/null

    # Restart SSH agent if it has crashed
    ps -ef | grep "${SSH_AGENT_PID}" | grep "ssh-agent" > /dev/null || {
      start_ssh_agent
    }

  # Start SSH agent for the first time
  else
    start_ssh_agent
  fi
fi
