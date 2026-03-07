# completion
autoload -U compinit; compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
source ~/.pnpm-completion.zsh
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey '^n' menu-complete

# theme
ZSH_THEME="robbyrussell"

# paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# plugins
plugins=(git z)

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# aliases
alias cr='cd $(git rev-parse --show-toplevel)'
alias ccr='code $(git rev-parse --show-toplevel)'
alias o="open"
alias pull="git pull"
alias push="git push"
alias diff="colordiff"
alias rm="trash"
alias c="code"
alias rgf='rg --files | rg'
alias ssh-pass='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# keybindings
bindkey -r "^G"

# mise
eval "$(mise activate zsh)"

# starship
eval "$(starship init zsh)"

export EDITOR=vim
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/yoshiki/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/yoshiki/.cache/lm-studio/bin"
