#!/bin/zsh

typeset -aU path

PAGER=less
MANPAGER=less
EDITOR=vim
VISUAL=vim
XTERMINAL=st
XLOCKER=slock
XBROWSER=firefox

export PAGER MANPAGER EDITOR VISUAL XTERMINAL XLOCKER XBROWSER

if [[ -x $(command -v go) ]] ; then
  export GOPATH=$HOME/src/go
  path[1,0]=$GOPATH/bin
  [[ ! -d $GOPATH/bin ]] && mkdir -p $GOPATH/bin
fi

if [[ -d "$HOME/.manyshift/bin" ]] ; then
  path[1,0]=$HOME/.manyshift/bin
fi

if [[ -d "$HOME/.rbenv" ]] ; then
  path[1,0]=$HOME/.rbenv/bin
  eval "$(rbenv init -)"
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
  pgrep 'ssh-agent$' > /dev/null || start_agent
else
  start_agent
fi

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]] ; then
  exec startx
fi

if [[ -z $DISPLAY && -n "$(pidof X)" && $TERM == 'screen' ]] ; then
  export DISPLAY=:0
fi
