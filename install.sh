#!/bin/bash

# disable prompts in yaourt
cat >~/.yaourtrc <<EOL
NOCONFIRM=1
BUILD_NOCONFIRM=1
EDITFILES=0
EOL

yaourt -S git curl wget nvim zsh tar jq tmux jdk8 terminator google-chrome intellij-idea-community-edition maven rofi unzip exa mmake hub kubectl kubectx doublecmd docker minikube diff-so-fancy visual-studio-code-bin nvim