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
alias claude="/Users/akiho/.claude/local/claude"
alias c="/Users/akiho/.claude/local/claude"

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

# Functions

goto() {
  local dir
  # Search for directories matching the input, excluding node_modules
  # -path "*/node_modules" -prune: skip node_modules directories
  # -o ... -print: print matching directories outside of node_modules
  dir=$(find . -path "*/node_modules" -prune -o -type d -iname "*$1*" -print | fzf)
  [[ -n "$dir" ]] && cd "$dir"
}

# port を kill するコマンド
# lsof -i :port番号
# kill pid
# ~/.zshrc に貼って reload
# ~/.zshrc に貼って reload
killport() {
  emulate -L zsh
  set -o pipefail

  # lsof を機械可読 (-F) で取得
  # p=PID, c=CMD, n=NAME, P=PROTO
  local lines
  lines=$(
    lsof -nP -iTCP -sTCP:LISTEN -F pcPn 2>/dev/null | \
    awk '
      function print_line() {
        if (pid && cmd && name) {
          port = name
          sub(/.*:/, "", port)          # ":" の後ろを残す
          sub(/ .*/, "", port)          # 空白以降（"(LISTEN)" 等）を削除
          if (port !~ /^[0-9]+$/) port = "?"
          printf "port=%-6s  pid=%-7s  cmd=%-20s  %s\n", port, pid, cmd, name
        }
      }
      /^p/ { pid=substr($0,2); next }
      /^c/ { cmd=substr($0,2); next }
      /^n/ { name=substr($0,2); print_line(); name="" ; next }
    '
  ) || return

  if [[ -z "$lines" ]]; then
    echo "LISTEN 中の TCP ポートは見つかりませんでした。"
    return 1
  fi

  # fzf で選択（複数可）
  local selection
  selection=$(printf "%s\n" "$lines" | \
    fzf --prompt='killport> ' \
        --header='[Enter]=実行  [Tab]=複数選択  [Esc]=キャンセル' \
        --multi) || return 1

  [[ -z "$selection" ]] && { echo "キャンセルしました。"; return 1; }

  # PID 抽出
  local pids=()
  while IFS= read -r line; do
    local pid
    pid=${${line#*pid=}%% *}
    [[ -n "$pid" ]] && pids+=("$pid")
  done <<< "$selection"

  (( ${#pids[@]} )) || { echo "PID を抽出できませんでした。"; return 1; }

  echo "終了対象 PID: ${pids[@]}"
  read -q "REPLY?まず正常終了(SIGTERM)します。続けますか？ [y/N] " || { echo; echo "中止しました。"; return 1; }
  echo
  kill "${pids[@]}"

  sleep 1

  # 残っていれば SIGKILL
  local remain=()
  for pid in "${pids[@]}"; do
    if kill -0 "$pid" 2>/dev/null; then
      remain+=("$pid")
    fi
  done

  if (( ${#remain[@]} )); then
    echo "まだ生きている PID: ${remain[@]}"
    read -q "REPLY?強制終了(SIGKILL)しますか？ [y/N] " || { echo; return 0; }
    echo
    kill -9 "${remain[@]}"
  fi
}

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


