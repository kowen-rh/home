#!/bin/zsh

typeset -aU path

PAGER=less
MANPAGER=less
EDITOR=vim
VISUAL=vim
XTERMINAL=gnome-terminal
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

if [[ -z $DISPLAY && -n "$(pidof X)" && $TERM == 'screen' ]] ; then
  export DISPLAY=:0
fi

if [[ -z $DISPLAY && "$(tty)" == '/dev/tty1' ]] ; then
  startx
fi
