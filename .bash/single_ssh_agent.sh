# Fix ssh-agent 6.9+ to work on OSX
# So you can use ed25519 and ecdsa
# works in zsh and bash, must run via `source /path/to/single_ssh_agent.sh`

which flock > /dev/null || ( echo "flock must be installed" && return 1 )

# File to hold existing SSH agent sesssion
WHOAMI_USER="$(whoami)"
SSH_ENV="${HOME}/.ssh/environment"
SSH_LOCK="/tmp/ssh-agent-lock-${WHOAMI_USER}"
SSH_TMP="/tmp/ssh-agent-${WHOAMI_USER}"
SSH_TMP_ADD="/tmp/ssh-agent-add-${WHOAMI_USER}"

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
    echo "source ${SSH_ENV}"
    source ${SSH_ENV}

    # Restart SSH agent if it has crashed
    ps -ef | \grep "${SSH_AGENT_PID}" | \grep -v grep | \grep "ssh-agent" > /dev/null || {
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

function wait_and_recover {

  if [ -e ${SSH_TMP_ADD} ]
  then
    # Nothing to wait for... just do it
    start_or_recover

    # Make sure it's touched again so it doesn't get deleted too early
    touch ${SSH_TMP_ADD}
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
}

function sleep_count_down {
  local secs=${1}
  while [ $secs -gt 0 ]; do
     echo -ne "$secs\033[0K\r"
     sleep 1
     : $((secs--))
  done
}

osType=$(uname)

# Handle for only OSX (Darwin) for now. This should only be called if it's a
# TTY; not PTS (pseudo TTY) or STY (pseudo screen TTY). Meaning it can't be a
# SSH session; it has to be a physical login.
if [ $osType = "Darwin" -o $osType = "Linux" ] && [ -z "${SSH_TTY}" ]
then

  which flock
  if [ "$?" = 0 ]
  then

    #tmpLockFileStatus=$(mktemp /tmp/ssh-agent-status.XXXXXXXXXX)
    #echo "1" > ${tmpLockFileStatus}

    (
      flock -x -n 8 || return 1
      #echo "$?" > ${tmpLockFileStatus}

      if [ ! -f ${SSH_TMP_ADD} ]
      then
        echo "Giving time exit if double locks acquired"
        sleep_count_down 5
      fi

      echo "Got Lock"
      start_or_recover

      # Make sure it's touched again so it doesn't get deleted too early
      touch ${SSH_TMP_ADD}

      rm -vf ${SSH_LOCK}
    ) 8> ${SSH_LOCK}

    #if [ "$(cat ${tmpLockFileStatus})" = 0 ]
    if [ "$?" = 0 ]
    then

      # reload SSH_ENV file because of scoping issues created by the parentheses
      source ${SSH_ENV}
    else

      echo "Failed to get Lock"
      wait_and_recover
    fi

    #rm -f ${tmpLockFileStatus}
  else

    # Create SSH_TMP lock
    if ( set -o noclobber; test ! -e ${SSH_TMP} && echo $$ > ${SSH_TMP} ) 2> /dev/null
    then

      start_or_recover

      # Make sure it's touched again so it doesn't get deleted too early
      touch ${SSH_TMP_ADD}
    else

      wait_and_recover
    fi
  fi
fi
