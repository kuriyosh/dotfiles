############################
# init setting
############################

# Path
set PATH ~/.scripts $PATH
set PATH ~/.scripts/private $PATH
set PATH /opt/homebrew/opt/mysql-client/bin $PATH
set PATH ~/.amplify/bin $PATH

set -x PATH (echo $PATH | tr ' ' '\n' | sort -u)

# https://github.com/withfig/fig/issues/1620
set -Ux FIG_WORKFLOWS_KEYBIND

pyenv init - | source

function nvm
   bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

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
alias lifelog 'code ~/Documents/Life/lifelog.md'

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
# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
