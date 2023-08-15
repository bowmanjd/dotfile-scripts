# Powershell shell helper functions for the dotfile basic method
# https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-a-simple-approach-without-a-bare-repo-2if7

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
# iwr -useb https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/basic.ps1 | iex
#
# Now you can use "dtfnew $repo_url" to set up a new repo, or "dtfrestore $repo_url"
# to download and configure an already populated repo.
function dtf {
  git -C "$HOME" @Args
}

function dtfclone {
  Param ([string]$repo)
  $tmpdir = [System.IO.Path]::GetTempPath()
  [string] $tmpname = [System.Guid]::NewGuid()
  $disposable = Join-Path $tmpdir $tmpname
  git clone -n --separate-git-dir "$HOME/.git" $repo $disposable
  Remove-Item -Recurse -Force $disposable

  # Uncomment one of the following 3 lines
  dtf config --local status.showUntrackedFiles no
  # echo '/**' >> "$HOME/.git/info/exclude"
  # echo '/**' >> "$HOME/.gitignore"; git add -f "$HOME/.gitignore"
}

function dtfnew {
  Param ([string]$repo)
  dtfclone $repo

  echo "Please add and commit additional files, then run"
  echo "git push -u origin HEAD"
}

function dtfrestore {
  Param ([string]$repo)
  dtfclone $repo

  dtf checkout
  if ($LASTEXITCODE) {
    echo "Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)"
    echo "git checkout"
  }
}
