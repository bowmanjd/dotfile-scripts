#!/bin/sh
# Unix shell helper functions for a dead simple way to manage dotfiles
# https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-a-simple-approach-without-a-bare-repo-2if7

# Copyright 2023 Jonathan Bowman. All documentation and code contained
# in this file may be freely shared in compliance with the
# Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
# and is provided "AS IS" without warranties or conditions of any kind.
#
# To use this script, first ask yourself if I can be trusted, then read the code
# below and make sure you feel good about it, then consider downloading and
# executing this code that comes with no warranties or claims of suitability:
#
# OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/simple.sh > $OUT; . $OUT
#
# Now you can use "dtfclone $REPO_URL" to set up a new repo, or
# to download and configure an already populated repo.

dtfclone () {
	REPO="$1"
  DISPOSABLE=$(mktemp -dt dtf-XXXXXX)
  git -C "$HOME" clone -c status.showUntrackedFiles=no -n --separate-git-dir "$HOME/.git" $REPO $DISPOSABLE
  rm -rf $DISPOSABLE
}
