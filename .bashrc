#!/bin/bash
# =============================================================================
# ~/.bashrc
# -----------------------------------------------------------------------------
# Settings for an interactive Bash shell session.
# =============================================================================

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# History settings. Ignore duplicates and verify history completions.
export HISTCONTROL=ignoreboth:erasedups
export HISTFILE="$XDG_DATA_HOME/bash/history"
shopt -s histverify

# Enable extended globbing.
shopt -s globstar

# Set the prompt.
PS1='
\u@\h: \W
\$ '

# =============================================================================
# Function: __load_config__(*dirs)
# -----------------------------------------------------------------------------
# Sources all of the .sh files in the given directories.
# =============================================================================
__load_config__() {
  for dir in "$@" ; do
    dir="$XDG_CONFIG_HOME/$dir"
    if [ -d "$dir/" ] ; then
      for file in $dir/*.sh ; do
        [ -r "$file" ] && . "$file"
      done
    fi
  done
}

# Load the standard configuration files and localized settings.
__load_config__ "sh/aliases.d" "sh/functions.d"
[ -r "$XDG_CONFIG_HOME/bash/bashrc.local" ] && . "$XDG_CONFIG_HOME/bash/bashrc.local"

CCFILE=${HOME}/.runccutil.sh;[ -f $CCFILE ] && source $CCFILE

alias ccutil="bccutil compile --lang en-US"
alias ccutil-pdf="bccutil compile --lang en-US --format pdf"
