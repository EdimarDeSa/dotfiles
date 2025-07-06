#!/bin/bash
export DEV_CONTAINER=1
export GITHUB_USERNAME="EdimarDeSa"

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

echo "export DEV_CONTAINER=1" >> ~/.config/.exports
