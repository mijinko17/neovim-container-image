#!/bin/bash

cd "$(dirname "$0")" || return

uid=$(id -u "$(whoami)")
target=${1:-default}
os="bookworm"
if [ "$target" = "rust" ]; then
	os="bullseye"
fi

docker build -t mijinko17/neovim-container-uid-"$uid":"$target"-develop --target "$target" --network host --build-arg uid="$uid" --build-arg os="$os" ..
