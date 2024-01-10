[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# starship prompt
eval "$(starship init zsh)"

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Mise setup
eval "$(~/.local/bin/mise activate zsh)"

autoload -Uz compinit && compinit

# keybinds
bindkey '^ '    autosuggest-accept
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[3~' delete-char

export EDITOR=vim
export PATH="$HOME/.local/bin":$PATH

if command -v batcat &> /dev/null; then
  alias cat="batcat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="batcat --theme \"Visual Studio Dark+\"" 
fi

alias gs='git status'
alias gd='git diff | bat'
alias glg='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gl='git pull'
alias gp='git push'
alias gco='git checkout'
alias gcm='git commit -m'
alias c='cd ~/code'
alias vim='nvim'

