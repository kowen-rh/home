#!/bin/sh
# =============================================================================
# Function: lw(*args)
# -----------------------------------------------------------------------------
# View the contents of the given shell file according to `$PATH` resolution.
# =============================================================================
lw() {
  $PAGER "$(which "$@")"
}