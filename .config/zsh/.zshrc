#!/bin/zsh
# =============================================================================
# ~/.zshrc
# -----------------------------------------------------------------------------
# Settings for an interactive Z shell session.
# =============================================================================

# Enable extended globbing.
setopt extended_glob

# History settings. Ignore duplicates, append to history file.
setopt append_history hist_ignore_dups hist_ignore_all_dups
HISTFILE="$XDG_DATA_HOME/zsh/history"
SAVEHIST=2000
HISTSIZE=2000

# Define Z shell completions and completion settings.
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' menu select
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*:rm:*' ignore-line yes
unsetopt nomatch

# =============================================================================
# Function: __prepend_sudo__()
# -----------------------------------------------------------------------------
# Prepends `sudo` to the currently active buffer.
# =============================================================================
function __prepend_sudo__(){
	[[ "$BUFFER" != 'sudo '* ]] && BUFFER="sudo $BUFFER" && CURSOR+=5
}

# Assign the key binding Alt+S to run the `__prepend_sudo__` function.
zle -N __prepend_sudo__
bindkey "^[s" __prepend_sudo__

# Name the window with the currently running command if we're not on a TTY.
if [[ "$TERM" != 'linux' ]] ; then
  typeset -ga precmd_functions
  typeset -ga preexec_functions

  function precmd {
    print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\a"
  }

  function preexec {
    printf "\033]0;%s\a" "$1"
  }
fi

# Set the prompt.
autoload -U colors && colors

PS1="
%{$fg[blue]%}%n%f@%{$fg[magenta]%}%m: %{$fg[yellow]%}%~
%{$fg[green]%}%# %{$reset_color%}"

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

# Load standard aliases and functions.
__load_config__ 'sh/aliases.d' 'sh/functions.d'

# Load localized settings.
[ -r "$XDG_CONFIG_HOME/zsh/zshrc.local" ] && . "$XDG_CONFIG_HOME/zsh/zshrc.local"
