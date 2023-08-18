#!/bin/sh
# Unix shell helper functions for the dotfile bare repo method

# Copyright 2023 Jonathan Bowman. All documentation and code contained
# in this file may be freely shared in compliance with the
# Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
# and is **provided "AS IS" without warranties or conditions of any kind**.
#
# To use this script, first ask yourself if I can be trusted, then read the code
# below and make sure you feel good about it, then consider downloading and
# executing this code that comes with no warranties or claims of suitability:
#
# OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/bare.sh > $OUT; . $OUT
#
# Now you can use "dtfnew $repo_url" to set up a new repo, or "dtfrestore $repo_url"
# to download and configure an already populated repo. Then use "dtf" instead of "git"
# to add, commit, push, pull, etc.

DOTFILES="$HOME/.dotfiles"

dtf () {
  git --git-dir="$DOTFILES" --work-tree="$HOME" "$@"
}

dtfnew () {
	REPO="$1"
  git clone -c status.showUntrackedFiles=no --bare "$REPO" "$DOTFILES"

  echo "You may now add and commit additional files"
  echo "using 'dtf add' and 'dtf commit', then run"
  echo "dtf push -u origin HEAD"
}

dtfrestore () {
	REPO="$1"
  git clone -c status.showUntrackedFiles=no --bare "$REPO" "$DOTFILES"
  dtf checkout || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndtf checkout'
  echo "Then you may add and commit additional files"
  echo "using 'dtf add' and 'dtf commit', then run"
  echo "dtf push -u origin HEAD"
}
