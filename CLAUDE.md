# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS configuration management. The repository uses symbolic linking to manage configuration files across the system.

## Installation and Setup

The primary installation method is through `install.sh`, which creates symbolic links from the repository to the appropriate locations in the home directory:

```bash
cd $HOME
git clone git@github.com:akifo/dotfiles.git
cd dotfiles
touch .gitconfig.local
# Configure user-specific git settings
echo "[user]" > .gitconfig.local
echo "	name = yourname" >> .gitconfig.local
echo "	email = yourname@gmail.com" >> .gitconfig.local
source install.sh
```

## Key Configuration Files

### Git Configuration (.gitconfig)
Contains extensive git aliases and worktree management commands:

**Worktree Management:**
- `g wl` - List worktrees
- `g wo` - Create worktree or open existing one (with fzf selection)
- `g wr` - Remove worktree (with fzf multi-select)

**Branch Management:**
- `g bl` - List local branches by date
- `g br` - List remote branches by date  
- `g swl` - Switch to local branch (fzf)
- `g swr` - Switch to remote branch (fzf)
- `g dlb` - Delete local branch (fzf)
- `g drb` - Delete remote branch (fzf)

**Advanced Git Operations:**
- `g up` - Fetch, prune, and delete merged branches
- `g dmb` - Delete merged branches (excludes master/main/dev)
- `g rho` - Reset current branch to remote origin
- `g dd` - Diff against origin/dev
- `g cd` - Checkout files from origin/dev

### Shell Configuration (.zshrc)
Configures zsh with multiple development tools:
- Starship prompt with custom configuration
- Git completion and color settings
- Tool integrations: direnv, volta, mise, conda, fzf, zoxide
- Development aliases for git (`g`) and docker-compose (`dc`)

### Starship Configuration (starship.toml)
Custom prompt configuration with:
- Memory usage display (always visible)
- Custom success symbol (➜)
- Package module disabled
- Nerd Font symbols (commented presets available)

## File Linking Strategy

The `install.sh` script creates symbolic links for:
- `.gitconfig` → `~/.gitconfig`
- `.gitconfig.local` → `~/.gitconfig.local` 
- `.zshrc` → `~/.zshrc`
- `.fzf.zsh` → `~/.fzf.zsh`
- `.starship.toml` → `~/.starship.toml`

The starship configuration also requires manual linking:
```bash
ln -fs "$HOME/dotfiles/starship.toml" "$HOME/.config/starship.toml"
```

## Git Workflow Architecture

The git configuration is built around fzf-powered interactive selection and extensive worktree usage. The worktree commands assume a `../$repo.w/$branch` directory structure for organizing multiple working trees.

## Development Environment

The configuration supports multiple development environments:
- Node.js via Volta
- Python via conda and mise
- Go with GOPATH configuration
- Docker/Docker Compose
- Google Cloud SDK
- Terraform with autocompletion