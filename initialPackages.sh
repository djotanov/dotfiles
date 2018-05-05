#!/bin/bash

# disable prompts in yaourt
cat >~/.yaourtrc <<EOL
NOCONFIRM=1
BUILD_NOCONFIRM=1
EDITFILES=0
EOL

yaourt -S neovim jq tmux jdk8 terminator google-chrome intellij-idea-community-edition maven rofi unzip exa mmake hub kubectl-bin kubectx doublecmd-qt5 docker minikube diff-so-fancy visual-studio-code-bin
