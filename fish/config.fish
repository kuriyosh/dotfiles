############################
# init setting
############################

# Paths
set PATH ~/.scripts $PATH
set PATH ~/.scripts/private $PATH

# anyenv
set -x PATH ~/.anyenv/bin $PATH
eval (anyenv init - | source)

# nodenv
nodenv rehash

# pyenv
set -x PYENV_ROOT $HOME/.anyenv/envs/pyenv
set -x PATH $PYENV_ROOT/bin $PATH
eval (pyenv init --path)

set -x PATH (echo $PATH | tr ' ' '\n' | sort -u)

############################
# alias
############################
alias rm "trash -r"
alias o open
alias g++ "g++-8"
alias cr "cd (git rev-parse --show-toplevel)"
alias pull "git pull"
alias push "git push"
alias gc "cd (ghq root)/(ghq list | peco)"
alias diff colordiff
alias ag 'ag --pager="less -R"'

# AWS CLI
alias el ec2-launcher
alias ej "english_to_japanese | less"
alias je "japanese_to_english | less"

# complete
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); aws_completer; end)'

############################
# functions
############################
function targz
    tar -zcvf $argv[2].tar.gz $argv[1]
end

############################
# Appearance
############################
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
