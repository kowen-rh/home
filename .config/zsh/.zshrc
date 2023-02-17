#!/bin/zsh
# =============================================================================
# ~/.zshrc
# -----------------------------------------------------------------------------
# Settings for an interactive Z shell session.
# =============================================================================

# Enable extended globbing.
setopt extended_glob

# Enable parameter expansion, arithmetic, and shell substitution in prompts.
setopt prompt_subst

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
function __prepend_sudo__() {
	[[ "$BUFFER" != 'sudo '* ]] && BUFFER="sudo $BUFFER" && CURSOR+=5
}

# Assign the key binding Alt+S to run the `__prepend_sudo__` function.
zle -N __prepend_sudo__
bindkey "^[s" __prepend_sudo__

# Name the window with the currently running command if we're not on a TTY.
if [[ "$TERM" != 'linux' ]] ; then
  typeset -ga precmd_functions
  typeset -ga preexec_functions

  function precmd() {
    print -Pn "\e]0;%(1j,%j job%(2j|s|); ,)%~\a"
  }

  function preexec() {
    printf "\033]0;%s\a" "$1"
  }
fi

# Set the prompt.
autoload -U colors && colors
autoload -Uz vcs_info

typeset -a precmd_functions
precmd_functions+=(vcs_info)

zstyle ':vcs_info:*' formats ' %F{green}%b%f'

PS1='
%F{blue}%n%F{green}@%F{magenta}%m${vcs_info_msg_0_}%F{green}: %F{yellow}%~
%F{green}%# %f'

# =============================================================================
# Function: __load_config__(*dirs)
# -----------------------------------------------------------------------------
# Sources all of the .sh files in the given directories.
# =============================================================================
function __load_config__() {
  for dir in "$@" ; do
    dir="$XDG_CONFIG_HOME/$dir"
    if [ -d "$dir/" ] ; then
      for file in $dir/*.sh ; do
        [ -r "$file" ] && . "$file"
      done
    fi
  done
}

# Initialize `rbenv if it exists.
[ -x "(command -v rbenv)" ] && eval "$(rbenv init - zsh)"

# Load standard aliases and functions.
__load_config__ 'sh/aliases.d' 'sh/functions.d'

# Load localized settings.
[ -r "$XDG_CONFIG_HOME/zsh/zshrc.local" ] && . "$XDG_CONFIG_HOME/zsh/zshrc.local"
