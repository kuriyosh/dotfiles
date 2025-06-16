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
alias o="open"
alias pull="git pull"
alias push="git push"
alias diff="colordiff"
alias rm="trash"
alias c="cursor"

# keybindings
bindkey -r "^G"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# prompt
## TODO: prompt をカスタマイズしたい

# mise
eval "$(mise activate zsh)"
