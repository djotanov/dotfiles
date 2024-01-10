#!/bin/bash

# base packages
if ! command -v zsh &>/dev/null; then
	sudo apt update
	sudo apt install -y zsh sudo openssh-server curl wget git lsb-release build-essential cmake bat fzf ripgrep tmux btop nvtop zip dirmngr gpg gawk zoxide stow

	echo "Installing zap..."
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# eza
if ! command -v eza &>/dev/null; then
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt update
	sudo apt install -y eza
fi

# Starship
if ! command -v starship &>/dev/null; then
	curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Rust
if ! command -v rustup &>/dev/null; then
	echo "Installing rust..."
	curl https://sh.rustup.rs -sSf | bash -s -- -y
fi

# Homebrew
if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# neovim
if ! command -v nvim &>/dev/null; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	brew install nvim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
fi

# mise (asdf alternative)
if ! command -v mise &>/dev/null; then
	curl https://mise.jdx.dev/install.sh | sh
fi
