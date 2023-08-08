Describe 'dtf basic' # example group

	Include /home/shelly/scripts/basic.sh

  Describe 'dtfnew'

    It 'clones repo'
			When call dtfnew /home/shelly/repos/bare.git
			The status should be success
			The stdout should include 'Please add and commit additional files'
			The stderr should include 'cloned an empty repository'
			The path "$HOME/.git/" should be exist
    End
  End
End
