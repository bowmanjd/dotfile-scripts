#!/bin/sh

hosttestdir="$(realpath $(dirname $0))"
hostdir="$(dirname $hosttestdir)"
scriptdir="/home/shelly/scripts"
testdir="$scriptdir/test"
container="dotfiles-test"

$hosttestdir/build.sh

podman run -it -v "$hostdir:$scriptdir:z" "$container" shellspec -c "$testdir" -s zsh
podman run -it -v "$hostdir:$scriptdir:z" "$container" shellspec -c "$testdir" -s dash
podman run -it -v "$hostdir:$scriptdir:z" "$container" shellspec -c "$testdir" -s bash
podman run -it -v "$hostdir:$scriptdir:z" "$container" pwsh -Command "Invoke-Pester -Output Detailed $testdir/test_basic_ps.Tests.ps1"
