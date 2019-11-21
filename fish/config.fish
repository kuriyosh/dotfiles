# Set Path
set PATH ~/.nodebrew/current/bin $PATH
set PATH ~/.scripts $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/Library/Android/sdk/tools $PATH
set PATH /usr/local/opt/mysql@5.7/bin/ $PATH
set PATH ~/.cargo/bin $PATH
set -x PATH $HOME/.pyenv/bin $PATH

# pyenv init
# eval (rbenv init - | source)
. (pyenv init - | psub)

# alias
alias rm "rmtrash"
alias emacs "/Applications/Emacs.app/Contents/MacOS/Emacs -nw -q -l ~/.emacs.d/cli.el"
alias o "open"
alias g++ "g++-8"
alias cr "cd (git rev-parse --show-toplevel)"
alias pull "git pull"
alias push "git push"
alias gc "cd (ghq root)/(ghq list | peco)"
alias diff "colordiff"

# AWS CLI
alias el ec2-launcher
alias ej "pbpaste | xargs -0 -I {} aws translate translate-text --text \"{}\" --source-language-code en --target-language-code ja | jq .TranslatedText"
alias je "pbpaste | xargs -0 -I {} aws translate translate-text --text \"{}\" --source-language-code ja --target-language-code en | jq .TranslatedText"

# functions
function targz
	tar -zcvf $argv[2].tar.gz $argv[1]
end
