#!/bin/zsh
# =============================================================================
# ~/.zprofile
# -----------------------------------------------------------------------------
# This file sets up the environment when logging in with the Z shell.
# =============================================================================

# Read the contents of ~/.profile if it exists.
[ -r "$HOME/.profile" ] && . "$HOME/.profile"

# Automatically start a graphical session if we're logging in from '/dev/tty1'
# and no graphical session is running.
[ -x "$(command -v startx)" ] && {
  [ -z "$DISPLAY" ] && [ "$(tty)" = '/dev/tty1' ] && startx &
}
