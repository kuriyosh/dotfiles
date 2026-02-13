# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# completion
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# theme
ZSH_THEME="robbyrussell"

# paths
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# plugins
plugins=(git z)

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# aliases
alias cr='cd $(git rev-parse --show-toplevel)'
alias ccr='cursor $(git rev-parse --show-toplevel)'
alias o="open"
alias pull="git pull"
alias push="git push"
alias diff="colordiff"
alias rm="trash"
alias c="cursor"
alias rgf='rg --files | rg'
alias ssh-pass='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# keybindings
bindkey -r "^G"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# mise
eval "$(mise activate zsh)"

# starship
eval "$(starship init zsh)"

export EDITOR=vim

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"