#!/bin/sh
# Unix shell helper functions for the dotfile basic method
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
# OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/basic.sh > $OUT; . $OUT
#
# Now you can use "dtfnew $REPO_URL $BRANCHNAME" to set up a new repo, or "dtfrestore $REPO_URL"
# to download and configure an already populated repo.

dtf () {
  git -C "$HOME" "$@"
}

dtfclone () {
  REPO="$1"
  DISPOSABLE=$(mktemp -dt dtf-XXXXXX)
  git clone -n --separate-git-dir "$HOME/.git" $REPO $DISPOSABLE
  rm -rf $DISPOSABLE

  # Uncomment one of the following 3 lines
  dtf config --local status.showUntrackedFiles no
  # echo '/**' >> "$HOME/.git/info/exclude"
  # echo '/**' >> "$HOME/.gitignore"; git add -f "$HOME/.gitignore"
}

dtfnew () {
  REPO="$1"
  dtfclone "$REPO"

  echo "Please add and commit additional files, then run"
  echo "git push -u origin HEAD"
}

dtfrestore () {
  REPO="$1"
  dtfclone "$REPO"
  dtf checkout || echo -e "Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ngit checkout"
}
