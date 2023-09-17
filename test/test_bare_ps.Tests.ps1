Import-Module Pester -PassThru

BeforeAll {
	$barerepo='/home/shelly/repos/bare.git'
	$baserepo='/home/shelly/repos/base.git'
	$branch='base'

	Remove-Item -Recurse -Force "$HOME/.dotfiles/"
	Remove-Item -Recurse -Force "$HOME/.git/"
	Remove-Item -Force "$HOME/.bashrc"
	Remove-Item "$HOME/.bashrc"
	rm -rf $HOME/.git "$DOTFILES" $HOME/.bashrc $HOME/.vimrc $HOME/.profile
	rm -rf /home/shelly/repos/bare.git/
		git init -b base --bare /home/shelly/repos/bare.git

	If(!(Test-Path -PathType container $barerepo))
	{
		git init -b $branch --bare $barerepo
	}

	. $PSScriptRoot/../bare.ps1
}


Describe 'dtfnew' {
	BeforeEach {
		If(Test-Path -PathType container "$HOME/.dotfiles/")
		{
			Remove-Item -Recurse -Force "$HOME/.dotfiles/"
		}
	}

	It 'Clones given repo' {
		dtfnew $barerepo
		$gitdir=Get-Item "$HOME/.git/"
		$gitdir | Should -Exist
	}

	It 'Adds a file' {
		dtfnew $barerepo
		New-Item .bashrc
		dtf add .bashrc
		dtf commit -m "Added .bashrc"
		dtf push -u origin HEAD
		$gitfiles = git -C $barerepo ls-tree --name-only HEAD
		$gitfiles | Should -Contain ".bashrc"
	}
}

Describe 'dtfrestore' {
	BeforeEach {
		If(Test-Path -PathType container "$HOME/.git/")
		{
			Remove-Item -Recurse -Force "$HOME/.git/"
		}
		If(Test-Path "$HOME/.profile")
		{
			Remove-Item -Force "$HOME/.profile"
		}
	}

	It 'Clones given repo, checks for .profile existence' {
		dtfrestore $baserepo
		$profile=Get-ChildItem -Attributes Hidden "$HOME/.profile"
		$profile | Should -Exist
	}

	It 'Clones given repo, adds .vimrc' {
		dtfrestore $baserepo
		New-Item .vimrc
		dtf add .vimrc
		dtf commit -m "Added .vimrc"
		dtf push
		$gitfiles = git -C $HOME/repos/base.git/ ls-tree --name-only HEAD
		$gitfiles | Should -Contain ".vimrc"
	}
}
