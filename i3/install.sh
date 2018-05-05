#!/bin/sh
[ "$(uname -s)" = "Darwin" ] && exit 0
test -z "$KEEP_TERMINATOR" || exit 0
mkdir -p ~/.i3/
ln -sf "$DOTFILES"/i3/config ~/.i3/config
ln -sf "$DOTFILES"/i3/myrofi ~/.i3/myrofi
