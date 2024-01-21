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
