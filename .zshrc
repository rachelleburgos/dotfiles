export ZSH=/Users/rachellesmac/.oh-my-zsh

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Path Configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Add custom paths
export PATH="$PATH:/Users/rachellesmac/.local/bin"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PNPM_HOME="/Users/rachellesmac/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Oh My Zsh Configuration
ZSH_THEME="minimal"

plugins=(
 git
 tmux
 iterm2
 macos
)

# Ensure custom plugins, like zsh-completions, are correctly included
fpath+=(${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Tools
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
