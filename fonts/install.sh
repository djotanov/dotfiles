#!/bin/sh
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FiraCode.zip"

install() {
	curl -L -s -o /tmp/fura.zip "$URL"
	mkdir -p /tmp/fura
	unzip /tmp/fura.zip -d /tmp/fura
	mv /tmp/fura/*.ttf "$1"
	mv /tmp/fura/*.otf "$1"
	rm -rf /tmp/fura /tmp/fura.zip
	fc-cache
}

mkdir -p ~/.local/share/fonts
install ~/.local/share/fonts
