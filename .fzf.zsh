# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# ghq list したものを fzf で曖昧検索し、選択したリポジトリへ移動
function ghq_fzf() {
    local repo_path=$(ghq list | fzf --preview "cat $(ghq root)/{}/README.* | head -n 80")
    if [[ -n $repo_path ]]; then
        cd "$(ghq root)/$repo_path"
    fi
}

# GitHub へリポジトリの作成から VSCode で開くまでの一連の流れをまとめた関数
# 1. リポジトリの作成
# 2. ghqでの取得
# 3. VSCodeで開く
# 使い方 -- $ ghcr my-super-program --public -d 'The best library ever!'
# https://qiita.com/ryo2132/items/2a29dd7b1627af064d7b
function ghcr {
    # $1 があるか確認
    if [ -z $1 ]; then
        echo "リポジトリ名を指定してください"
        return
    fi

    # デフォルトは --private を付与
    if [ -z $2 ]; then
        gh repo create $argv --private
    else
        gh repo create $argv
    fi

    ghq get git@github.com:akifo/$1.git
    code /Users/akiho/github/github.com/akifo/$1
}
