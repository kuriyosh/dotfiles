# fpath (must be before compinit)
fpath=($HOME/.docker/completions $fpath)

# completion
autoload -U compinit; compinit
zmodload zsh/complist

# oh-my-zsh
ZSH_THEME=""
plugins=(git z)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# completion (after oh-my-zsh to avoid being overwritten)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
source ~/.pnpm-completion.zsh
zstyle ':completion:*' menu select
bindkey '^n' menu-complete

# paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# environment variables
export EDITOR="emacsclient -nw -a ''"

# aliases
alias e='emacsclient -nw -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'
alias cr='cd $(git rev-parse --show-toplevel)'
alias ccr='code $(git rev-parse --show-toplevel)'
alias o="open"
alias pull="git pull"
alias push="git push"
alias diff="colordiff"
alias rm="trash"
alias c="code"
alias ls='eza --grid --color auto --icons --sort=type'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza --grid --all --color auto --icons --sort=type'
alias lt='eza --tree --level=2 --icons'
alias rgf='rg --files | rg'

alias ssh-pass='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# keybindings
bindkey -r "^G" # unbind list-expand to free ^G prefix

# mise
eval "$(mise activate zsh)"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"
