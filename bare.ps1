# Powershell shell helper functions for the dotfile bare repo method

# Copyright 2023 Jonathan Bowman. All documentation and code contained
# in this file may be freely shared in compliance with the
# Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
# and is **provided "AS IS" without warranties or conditions of any kind**.
#
# To allow this script to be executed, first ask yourself if I can be trusted,
# then read the code below and make sure you feel good about it, then consider
# allowing scripts to be run by you with the following:
#
# Set-ExecutionPolicy RemoteSigned -scope CurrentUser
#
# Then download and execute this code that comes with no warranties or claims
# of suitability:
#
# iwr -useb https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/bare.ps1 | iex
#
# Now you can use "dtfnew $repo_url" to set up a new repo, or "dtfrestore $repo_url"
# to download and configure an already populated repo. Then use "dtf" instead of "git"
# to add, commit, push, pull, etc.

$DOTFILES = "$HOME\.dotfiles"

function dtf {
  git --git-dir="$DOTFILES" --work-tree="$HOME" @Args
}

function dtfnew {
  Param ([string]$repo)
  git clone -c status.showUntrackedFiles=no --bare $repo $DOTFILES

  echo "You may now add and commit additional files"
  echo "using 'dtf add' and 'dtf commit', then run"
  echo "dtf push -u origin HEAD"
}

function dtfrestore {
  Param ([string]$repo)
  git clone -c status.showUntrackedFiles=no --bare $repo $DOTFILES
  dtf checkout
  if ($LASTEXITCODE) {
    echo "Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)"
    echo "dtf checkout"
  }
  echo "Then you may add and commit additional files"
  echo "using 'dtf add' and 'dtf commit', then run"
  echo "dtf push -u origin HEAD"
}
