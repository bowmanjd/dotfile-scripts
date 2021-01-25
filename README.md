# dotfile-scripts

Scripts for storing and versioning home directory configuration files, aka "dotfiles"

An explanatory series of articles I wrote on the subject [is available here][article].

## Compatibility

Unless you have configured things differently (good for you), Linux users will probably use Bash, Windows users Powershell, and Mac users Zsh.

The Unix shell scripts (they end with `.sh` not Powershell), have been tested on [Bash](https://www.gnu.org/software/bash/), [Zsh](https://www.zsh.org/), Busybox's Ash which is actually [Dash](http://gondor.apana.org.au/~herbert/dash/).

The [Powershell](https://docs.microsoft.com/en-us/powershell/) scripts (they end with `.ps1`) were tested on Windows, with Powershell version 5.1.

## Installation

> Warning: before downloading and executing any of these scripts, read over them. I make no claims that they will work or even be safe on your system. You may want to check the function names, for instance, to make sure they do not overwrite vital functions you have already composed. You should also make sure I am not a nefarious individual intent on installing malware on your system or erasing all your files. A little paranoia is in order, as usual.

In general, the instructions for usage are available in comments at the top of each script, and/or in the [articles I wrote][article].

Powershell users will want to first make sure their execution policies allow executing code that is unsigned. For instance the following will allow code you write (or copy and paste, or pipe from `Invoke-WebRequest` to `Invoke-Expression`) to execute, but insist that downloaded files have to be signed.

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

Read more about [setting Execution Policies on the Powershell docs](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy).

So, if you download one of the Powershell scripts and want to execute it, you may still need to unblock it with [`Unblock-File`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file).

## Contributing

Feel free to open an issue if you have suggestions, questions, or glowing affirmations.

## Copyright and License

Copyright 2021 Jonathan Bowman. All documentation and code contained in these files may be freely shared in compliance with the [Apache License, Version 2.0][license] and is **provided “AS IS” without warranties or conditions of any kind**.

[article]: https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-a-simple-approach-without-a-bare-repo-2if7
[license]: LICENSE
[apachelicense]: http://www.apache.org/licenses/LICENSE-2.0
