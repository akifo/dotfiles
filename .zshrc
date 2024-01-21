# Git
export PATH="/usr/local/opt/git/bin:$PATH"

# hombebrew
export PATH="/opt/homebrew/bin:$PATH"

# Postgres
# export PGDATA=/usr/local/var/postgres

# Sublime Text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit
compinit

# https://github.com/sたrarship/starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/dotfiles/starship.toml

# ファイルの色指定
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:ex=01;32'
alias ls='ls -G'

# 補完時の色設定
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/akiho/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/akiho/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/akiho/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/akiho/google-cloud-sdk/completion.zsh.inc'; fi

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# MySQL
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# alias
alias dc='docker-compose'
alias g='git'

# fastly
eval "$(fastly --completion-script-zsh)"

# direnv  -- homebrew で install した
eval "$(direnv hook zsh)"

# terraform autocomplete のため
# https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/gcp-get-started#enable-tab-completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Varnish
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"
