#!/bin/bash

target=${1:-default}

cd "$(dirname "$0")" || return
uid=$(id -u "$(whoami)")
docker build -t mijinko17/neovim-container-uid-"$uid":"$target"-develop --target "$target" --network host --build-arg uid="$uid" ..
