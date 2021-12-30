#!/bin/bash

# kill ssh-agent process and remove pid file
invalidate_ssh_agent() {
  if [ -f "$1" ]; then
    kill -9 $(cat "$1")
  fi
  rm -f "$1"
}

# check root access
if [ "$EUID" -ne 0 ]; then
  echo "Require root access"
  exit
fi

# create base folder
mkdir -p data/jenkins
mkdir -p master/ssh

# get unique param for use as id
SSH_FILE=master/ssh/id_rsa
FILE_PATH=$(pwd)
CON_NAME=${FILE_PATH//\//\_}
CON_NAME_PFX="${CON_NAME:1}"
# save to tmp for autoremove after reboot
SSH_AGENT_PID_FILE='/tmp/'$CON_NAME_PFX'_agent_pid'
# docker privileged mode
PRIVILEGED=false
if [ "$2" = "privileged" ]; then
  PRIVILEGED=true
fi

# switch
if [ "$1" = "start" ]; then
  # invalidate currently ssh agent and run new
  invalidate_ssh_agent "$SSH_AGENT_PID_FILE"
  eval "$(ssh-agent -s)"

  # save pid ssh-agent
  echo "$SSH_AGENT_PID" >"$SSH_AGENT_PID_FILE"

  # create env file for transfer at docker-compose
  echo "CON_NAME_PFX=$CON_NAME_PFX" >.env
  echo "SSH_AUTH_SOCK=/ssh-agent" >>.env
  echo "PRIVILEGED=$PRIVILEGED" >>.env

  # checking exist ssh key
  if [ ! -f $SSH_FILE ]; then
    # ssh key not exist, generate and propagation
    echo "Generate $SSH_FILE"
    ssh-keygen -f $SSH_FILE -q
    cp $SSH_FILE".pub" app/ssh/authorized_keys
    cp $SSH_FILE".pub" postgresql/ssh/authorized_keys
  fi

  # forward ssh-agent and run
  ssh-add $SSH_FILE

  # run docker-compose
  docker-compose up -d --build
elif [ "$1" = "stop" ]; then
  # invalidate currently ssh agent and run new
  invalidate_ssh_agent "$SSH_AGENT_PID_FILE"

  # docker-compose stop
  docker-compose down
elif [ "$1" = "ssh_clear" ]; then
  # remove ssh key
  rm -f $SSH_FILE
else
  echo "Wrong command"
fi
