Import-Module Pester -PassThru

BeforeAll {
	$barerepo='/home/shelly/repos/bare.git'
	$baserepo='/home/shelly/repos/base.git'
	$branch='base'

	If(!(Test-Path -PathType container $barerepo))
	{
		git init -b $branch --bare $barerepo
	}

	. $PSScriptRoot/../basic.ps1
}


Describe 'dtfnew' {
	BeforeEach {
		If(Test-Path -PathType container "$HOME/.git/")
		{
			Remove-Item -Recurse -Force "$HOME/.git/"
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
		git add .bashrc
		git commit -m "Added .bashrc"
		git push -u origin HEAD
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
		git add .vimrc
		git commit -m "Added .vimrc"
		git push
		$gitfiles = git -C $HOME/repos/base.git/ ls-tree --name-only HEAD
		$gitfiles | Should -Contain ".vimrc"
	}
}
