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

# Load aki completion
source "/Users/akiho/.zsh/aki-completion.zsh"

# mise
# https://github.com/jdx/mise
eval "$(~/.local/bin/mise activate zsh)"

# bun completions
[ -s "/Users/akiho/.bun/_bun" ] && source "/Users/akiho/.bun/_bun"

# cursor
# alias cursor="cursor"
alias cursor='open -a Cursor "$1"'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/akiho/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/akiho/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/akiho/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/akiho/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PATH="$HOME/.local/share/pnpm:$PATH"
alias claude="/Users/akiho/.claude/local/claude"
