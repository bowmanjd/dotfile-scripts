# Unix shell helper functions for the dotfile basic method
# https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-a-simple-approach-without-a-bare-repo-2if7

# Copyright 2021 Jonathan Bowman. All documentation and code contained
# in this file may be freely shared in compliance with the
# [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
# and is **provided “AS IS” without warranties or conditions of any kind**.
#
# To use this script, first ask yourself if I can be trusted, then read the code
# below and make sure you feel good about it, then consider downloading and
# executing this code that comes with no warranties or claims of suitability:
#
# OUT="$(mktemp)"; wget -q -O - https://raw.githubusercontent.com/bowmanjd/dotfile-scripts/main/basic.sh
#
# Now you can use "dtfnew $repo_url" to set up a new repo, or "dtfrestore $repo_url"
# to download and configure an already populated repo.


dtfnew () {
  git init -b base
  git remote add origin $1

  # Uncomment one of the following 3 lines
  git config --local status.showUntrackedFiles no
  # echo '/**' >> .git/info/exclude
  # echo '/**' >> .gitignore; git add -f .gitignore

  echo "Please add and commit additional files, then run"
  echo "git push -u origin base"
}

dtfrestore () {
  git init -b base
  git remote add origin $1

  # Uncomment one of the following 2 lines unless repo has '/**' line in a .gitignore
  git config --local status.showUntrackedFiles no
  # echo '/**' >> .git/info/exclude

  git fetch --set-upstream origin base

  git switch --no-overwrite-ignore base || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ngit switch base'
}
