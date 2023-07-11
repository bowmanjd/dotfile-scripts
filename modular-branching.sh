#!/bin/sh
# Unix shell helper functions for a modular bare repo approach with branching

# Copyright 2023 Jonathan Bowman. All documentation and code contained
# in this file may be freely shared in compliance with the
# Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
# and is provided "AS IS" without warranties or conditions of any kind.
#
# To use this script, first ask yourself if I can be trusted, then read the code
# below and make sure you feel good about it, then consider downloading and
# executing this code that comes with no warranties or claims of suitability:
#
# OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/modular-branching.sh > $OUT; . $OUT
#
# Now you can use "dtfnew $module $repo_url" to set up a new repo, or
# "dtfrestore $module $repo_url" to download and configure an already populated
# repo to a specific directory. Then use "dtf $module " instead of "git" to
# add, commit, push, pull, etc.

DOTFILES="$HOME/.dotfiles"

dtf () {
  MODULE=$1
  shift
  git --git-dir="$DOTFILES/$MODULE" --work-tree="$HOME" $@
}

dtfnew () {
  MODULE=$1
  shift
  mkdir -p "$DOTFILES/$MODULE"
  git clone --bare $1 "$DOTFILES/$MODULE"
  dtf $MODULE config --local status.showUntrackedFiles no
  dtf $MODULE switch -c $MODULE

  echo "Please add and commit additional files"
  echo "using 'dtf $MODULE add' and 'dtf $MODULE commit', then run"
  echo "dtf $MODULE push -u origin base"
}

dtfrestore () {
  MODULE=$1
  shift
  git clone --single-branch -b $MODULE --bare $1 "$DOTFILES/MODULE"
  dtf $MODULE config --local status.showUntrackedFiles no
  dtf $MODULE checkout || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndtf $MODULE checkout'
}


