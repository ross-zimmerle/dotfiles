# Dotfiles

Personal dotfiles managed via a bare Git repository, designed to be:
	•	✅ Easy to maintain
	•	✅ Safe to sync (no secrets committed)
	•	✅ Fast to bootstrap on a new machine
	•	✅ Friendly to a CLI-heavy workflow (zsh, tmux, nvim, git)

This repo tracks selected files in $HOME directly while storing Git metadata separately.

⸻

Philosophy
	•	Opt-in tracking only — nothing is tracked unless explicitly added
	•	Files live where tools expect them — no symlinks
	•	Secrets never committed — local overrides are untracked
	•	Minimal dependencies — just Git

⸻

Repository Model (Important)

This repo is a bare Git repository.
	•	Git metadata lives in: ~/.dotfiles
	•	Your home directory ($HOME) is the working tree
	•	Files are edited in place (e.g. ~/.zshrc, ~/.config/nvim/*)

An alias called dot is used instead of git to manage everything safely.

⸻

Prerequisites
	•	Git
	•	zsh (recommended)
	•	tmux
	•	Neovim
	•	A POSIX shell environment (macOS or Linux)

⸻

Bootstrap (New Machine)

1. Clone the bare repo

git clone --bare git@github.com:YOUR_USER/dotfiles.git ~/.dotfiles

2. Define the dot alias (temporary)

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

3. Checkout files into $HOME

dot checkout

If Git reports conflicts (existing default files), choose one:

Option A: Backup and retry (safe)

mkdir -p ~/.dotfiles-backup
dot checkout 2>&1 | egrep "\s+\." | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
dot checkout

Option B: Force checkout (destructive)

dot checkout -f

4. Hide untracked files (required)

dot config --local status.showUntrackedFiles no


⸻

Daily Usage

Common commands

dot status
dot add ~/.zshrc
dot commit -m "Update zsh config"
dot push

Diff a file

dot diff ~/.tmux.conf

Log history

dot log --oneline


⸻

What’s Tracked

Typically included
	•	Shell: .zshrc, .zprofile, aliases, functions
	•	Git: .gitconfig, .gitignore_global, ~/.config/git/*
	•	Tmux: .tmux.conf
	•	Neovim: ~/.config/nvim/*
	•	Terminal configs (WezTerm, Alacritty, etc.)
	•	CLI tool configs: fzf, delta, rg, bat, starship
	•	Scripts: ~/.local/bin/*

Explicitly not included
	•	Secrets (API keys, tokens, credentials)
	•	SSH private keys
	•	.env files
	•	Cache / history files
	•	Machine-specific paths or binaries

⸻

Local Overrides (Work vs Personal, Machine-Specific)

Shared config files source local, untracked overrides.

These files must not be committed.

Zsh

# ~/.zshrc (tracked)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

Git

# ~/.gitconfig (tracked)
[include]
  path = ~/.gitconfig.local

Tmux

# ~/.tmux.conf (tracked)
if-shell "test -f ~/.tmux.conf.local" "source-file ~/.tmux.conf.local"

Create the corresponding *.local files per machine.

⸻

Ignoring Secrets & Locals

Global ignore file (recommended):

git config --global core.excludesfile ~/.gitignore_global

Example ~/.gitignore_global:

# Local overrides
.zshrc.local
.gitconfig.local
.tmux.conf.local

# Secrets
.env
.env.*
.ssh/

# OS junk
.DS_Store


⸻

Directory Layout (Recommended)

~/
  .zshrc
  .tmux.conf
  .gitconfig
  .gitignore_global
  .config/
    nvim/
    git/
  .local/
    bin/
      codex-spec.sh
      wtf-branch

	•	Keep scripts in ~/.local/bin and ensure it’s on PATH
	•	Keep docs close to configs when helpful

⸻

Updating & Reloading
	•	Zsh: source ~/.zshrc
	•	Tmux: tmux source-file ~/.tmux.conf
	•	Neovim: restart or :source %
	•	Git config: git config --list

⸻

Commit Discipline
	•	Small, focused commits
	•	Descriptive messages
	•	Tag major milestones (e.g. nvim-v1, tmux-overhaul)

⸻

Safety Notes
	•	⚠️ Never commit secrets
	•	⚠️ Be careful with dot checkout -f
	•	⚠️ Review diffs before committing

⸻

Why Bare Repo?
	•	No symlinks
	•	No extra tools
	•	Files live where programs expect them
	•	Git history stays out of $HOME
	•	Scales cleanly over time

⸻

Future Improvements (Optional)
	•	Encrypted secrets (age / sops)
	•	Per-host conditionals
	•	Bootstrap script (curl | sh)
	•	Migration to chezmoi if templating becomes necessary

⸻

TL;DR

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot status




