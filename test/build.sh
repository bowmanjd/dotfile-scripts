#!/bin/sh

thisdir=$(dirname $0)

podman build -t dotfiles-test:latest -t "dotfiles-test:$(date -r $thisdir/Dockerfile +%Y.%m.%d)" -f "$thisdir/Dockerfile" .


