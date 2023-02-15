#!/bin/sh
# =============================================================================
# ~/.profile
# -----------------------------------------------------------------------------
# This file sets up the environment for all login shells for this user.
# 
# Note that this file is written as a POSIX-compliant shell script to ensure
# that its contents can be read regardless of the chosen shell.
# =============================================================================

# =============================================================================
# ENVIRONMENT
# =============================================================================

# Explicitly set variables related to the XDG base directory specification.
XDG_CACHE_HOME="$HOME/.cache"
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_RUNTIME_DIR" ] && export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME

# Set the default pager and disable history for it.
PAGER='less'
MANPAGER="$PAGER"
LESSHISTFILE=-
export PAGER MANPAGER

# Set the default editor for terminal applications.
EDITOR='vim'
VISUAL="$EDITOR"
export EDITOR VISUAL

# Read the ~/.config/vim/vimrc file when opening Vim. This effectively replaces
# the ~/.vimrc file used by default, conforming to the XDG Base Directory
# specification.
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Redefine where the configuration file for `readline` resides, conforming to
# the XDG Base Directory specification.
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# Set the default terminal emulator, screen locker, and web browser for X.
XTERMINAL='st'
XLOCKER='slock'
XBROWSER='firefox'
export XTERMINAL XLOCKER XBROWSER

# Ensure we have access to the $DISPLAY environment variable within a terminal
# multiplexer. This allows us to open graphical applications.
if [ -z "$DISPLAY" ] && [ -n "$(pidof X)" ] && [ "$TERM" == 'screen' ] ; then
	export DISPLAY=:0
fi

# =============================================================================
# FUNCTIONS
# =============================================================================

# =============================================================================
# Function: __prepend_path__(dir)
# -----------------------------------------------------------------------------
# Adds the given argument to the $PATH environment variable if it does not
# already exist.
# =============================================================================
__prepend_path__() {
	case ":$PATH:" in
		*:"$1":*) ;; # Do nothing if the path already exists.
		*) PATH="$1:${PATH:+$PATH}" ;;
	esac
}

# =============================================================================
# PATHS
# =============================================================================

# Set up the environment for Go development if we have the Go compiler
# installed.
[ -x "$(command -v go)" ] && {
	export GOPATH="$HOME/src/go"
	[ ! -d "$GOPATH/bin" ] && mkdir -p "$GOPATH/bin"
	__prepend_path__ "$GOPATH/bin"
}

# Add the directory for cargo binaries to our `$PATH` if it exists.
[ -d "$HOME/.cargo/bin" ] && __prepend_path__ "$HOME/.cargo/bin"

# Add the manyshift binary shims to our `$PATH` if the directory for them
# exists.
[ -d "$HOME/.manyshift/bin" ] && __prepend_path__ "$HOME/.manyshift/bin"

# If the `~/.rbenv` directory exists, we have `rbenv` installed. Add the binary
# directory to our `$PATH` and initialize `rbenv`.
[ -d "$HOME/.rbenv" ] && {
	__prepend_path__ "$HOME/.rbenv/bin"
	eval "$(rbenv init -)"
}

# Load local profile settings if they exist.
[ -r "$XDG_CONFIG_HOME/sh/profile.local" ] && \
  . "$XDG_CONFIG_HOME/sh/profile.local"

# Add the `~/bin` directory to `$PATH` if it exists.
[ -d "$HOME/bin" ] && __prepend_path__ "$HOME/bin"

unset __prepend_path__
