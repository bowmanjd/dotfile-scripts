#!/bin/sh

hosttestdir="$(realpath $(dirname $0))"
hostdir="$(dirname $hosttestdir)"
scriptdir="/home/shelly/scripts"
testdir="$scriptdir/test"
container="dotfiles-test"

$hosttestdir/build.sh

podman run -it -v "$hostdir:$scriptdir:z" "$container" zsh -c "$testdir/test_basic_dtfnew.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" dash -c "$testdir/test_basic_dtfnew.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" bash -c "$testdir/test_basic_dtfnew.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" zsh -c "$testdir/test_basic_dtfrestore.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" dash -c "$testdir/test_basic_dtfrestore.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" bash -c "$testdir/test_basic_dtfrestore.sh"
podman run -it -v "$hostdir:$scriptdir:z" "$container" pwsh -Command "Invoke-Pester -Output Detailed $testdir/test_basic_ps.Tests.ps1"
