#!/bin/sh
wd=$(pwd)
ln -sf ${wd}/.gitconfig ~/.gitconfig
ln -sf ${wd}/.gitconfig.local ~/.gitconfig.local
ln -sf ${wd}/.zshrc ~/.zshrc
ln -sf ${wd}/.fzf.zsh ~/.fzf.zsh
ln -sf ${wd}/.starship.toml ~/.starship.toml
