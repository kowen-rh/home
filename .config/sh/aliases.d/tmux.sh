#!/bin/sh
# =============================================================================
# Alias: tmux.sh
# -----------------------------------------------------------------------------
# Defines common aliases for the `tmux` terminal multiplexer if installed.
# =============================================================================
[ -x "$(command -v tmux)" ] && {
  alias t='TMUX= tmux'
  alias tn='TMUX= tmux new -s'
  alias ta='TMUX= tmux attach -t'
}
