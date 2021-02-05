# Powershell shell helper functions for a modular bare repo approach

# Copyright 2021 Jonathan Bowman. All documentation and code contained
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
# iwr -useb https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/modulear.ps1 | iex
#
# Now you can use "dtfnew $module $repo_url" to set up a new repo, or
# "dtfrestore $module $repo_url" to download and configure an already populated
# repo to a specific directory. Then use "dtf $module" instead of "git" to
# add, commit, push, pull, etc.

$dotfiles = "$HOME\.dotfiles"

function dtf {
  Param ([string]$Module)
  git --git-dir="$dotfiles\$Module" --work-tree="$HOME" @Args
}

function dtfnew {
  Param ([string]$Module, [string]$Repo)
  mkdir -f "$dotfiles/$Module"
  git clone --bare $Repo "$dotfiles/$Module"
  dtf $Module config --local status.showUntrackedFiles no

  echo "Please add and commit additional files"
  echo "using 'dtf $Module add' and 'dtf $Module commit', then run"
  echo "dtf $Module push -u origin HEAD"
}

function dtfrestore {
  Param ([string]$Module, [string]$Repo)
  git clone --bare $Repo "$dotfiles/MODULE"
  dtf $Module config --local status.showUntrackedFiles no
  dtf $Module checkout
  if ($LASTEXITCODE) {
    echo "Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)"
    echo "dtf $Module checkout"
  }
}
