Describe 'dtf bare' # example group

	Include /home/shelly/scripts/bare.sh
	Path dotfiles="$HOME/.dotfiles/"
	DOTFILES="$HOME/.dotfiles/"

	clean() {
		rm -rf $HOME/.git "$DOTFILES" $HOME/.bashrc $HOME/.vimrc $HOME/.profile
		rm -rf /home/shelly/repos/bare.git/
		git init -b base --bare /home/shelly/repos/bare.git
	}

	Describe 'dtfnew'

    It 'clones repo'
			When call dtfnew /home/shelly/repos/bare.git
			The status should be success
			The stdout should include 'You may now add and commit additional files'
			The stderr should include 'cloned an empty repository'
			The path dotfiles should be exist
    End

		#It 'clones repo'
		#	When call dtfnew /home/shelly/repos/bare.git
		#	The status should be success
		#	The stdout should include 'You may now add and commit additional files'
		#	The stderr should include 'cloned an empty repository'
		#	The path gitdir should be exist
		#End

		It 'creates .bashrc'
			When call touch "$HOME/.bashrc"
			The status should be success
			The path "$HOME/.bashrc" should be exist
		End

		It 'stages .bashrc'
			When call dtf add "$HOME/.bashrc"
			The status should be success
		End

		It 'commits .bashrc'
			When call dtf commit -m "Add file"
			The status should be success
			The stdout should include '1 file changed, 0 insertions(+), 0 deletions(-)'
			The stdout should include '.bashrc'
		End

		It 'pushes changes to remote'
			When call dtf push -u origin HEAD
			The status should be success
			The stdout should include "branch 'base' set up to track 'origin/base'."
			The stderr should include "HEAD -> base"
		End

		It '.bashrc exists in remote'
			When call git -C /home/shelly/repos/bare.git ls-tree --name-only HEAD
			The stdout should include .bashrc
		End
  End

	Describe 'dtfrestore'

		BeforeAll 'clean'

    It 'clones repo'
			When call dtfrestore /home/shelly/repos/laptop.git
			The status should be success
			The path dotfiles should be exist
			The path $HOME/.profile should be exist
			The stdout should include "Then you may add and commit additional files"
			The stderr should include "done"
    End

		It 'adds .vimrc'
			addvimrc () {
				touch $HOME/.vimrc
				dtf add $HOME/.vimrc
				dtf commit -m "Added .vimrc"
				dtf push -u origin HEAD
			}
			When call addvimrc
			The stdout should include '1 file changed, 0 insertions(+), 0 deletions(-)'
			The stdout should include '.vimrc'
			The stderr should include "HEAD -> base"
		End

		It '.vimrc exists in remote'
			When call git -C /home/shelly/repos/laptop.git ls-tree --name-only HEAD
			The stdout should include .vimrc
		End

  End
End
