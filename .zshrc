#!/bin/zsh

setopt extended_glob

autoload -U colors && colors

PS1="
%{$fg[blue]%}%n%f@%{$fg[magenta]%}%m: %{$fg[yellow]%}%~
%{$fg[green]%}%# %{$reset_color%}"

setopt append_history hist_ignore_dups hist_ignore_all_dups
HISTFILE=$HOME/.zsh_history
SAVEHIST=2000
HISTSIZE=2000

autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*:rm:*' ignore-line yes

unsetopt nomatch

function prepend_sudo(){
  [[ $BUFFER != 'sudo '* ]] && BUFFER="sudo $BUFFER" && CURSOR+=5
}
zle -N prepend_sudo
bindkey "^[s" prepend_sudo

if [[ $TERM != 'linux' ]] ; then
  typeset -ga precmd_functions
  typeset -ga preexec_functions

  function precmd {
    print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\a"
  }
  function preexec {
    printf "\033]0;%s\a" "$1"
  }
fi

[[ -e $HOME/.zsh/aliases ]] && source $HOME/.zsh/aliases
[[ -e $HOME/.zsh/functions ]] && source $HOME/.zsh/functions
[[ -e $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
