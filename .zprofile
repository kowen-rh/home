#!/bin/zsh

typeset -U path

export PAGER=less
export MANPAGER=less
export EDITOR=vim
export VISUAL=vim
export BROWSER=chromium

if [[ -x $(command -v go) ]] ; then
  export GOPATH=~/src/go
  path[1,0]=$GOPATH/bin
  [[ ! -d $GOPATH/bin ]] && mkdir -p $GOPATH/bin
fi

path[1,0]=~/bin

SSH_ENV="$HOME/.ssh/env"

function start_agent() {
  /usr/bin/ssh-agent | sed '/^echo/d' > "${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  source "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add
}

if [[ -f "${SSH_ENV}" ]] ; then
  source "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent
  }
else
  start_agent
fi

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]] ; then
  exec startx
fi

if [[ -z $DISPLAY && -n "$(pidof X)" && $TERM == 'screen' ]] ; then
  export DISPLAY=:0
fi
