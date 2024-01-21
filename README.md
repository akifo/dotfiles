# Akiho's dotfiles

## Installation

```bash
cd $HOME
git clone git@github.com:akifo/dotfiles.git
cd dotfiles
touch .gitconfig.local
# create .gitconfig.local, edit yourname
echo "[user]" > .gitconfig.local
echo "	name = yourname" >> .gitconfig.local
echo "	email = yourname@gmail.com" >> .gitconfig.local
source install.sh
```

## Inspired by ...
- https://github.com/mathiasbynens/dotfiles
- http://qiita.com/b4b4r07/items/b70178e021bef12cd4a2


## starship
https://dev.classmethod.jp/articles/customize-prompt-with-starship/

```
ln -fs "$HOME/dotfiles/starship.toml" "$HOME/.config/starship.toml"
```
