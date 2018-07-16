# Set Path
set PATH ~/.nodebrew/current/bin $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/Library/Android/sdk/tools $PATH
set -x PATH $HOME/.pyenv/bin $PATH

# pyenv init
. (pyenv init - | psub)

# rm 
alias rm "rmtrash"
alias emacs "/Applications/Emacs.app/Contents/MacOS/Emacs -nw -q -l ~/.emacs.d/cli.el"

# cd > ls
function cd
  builtin cd $argv
  ls -a
end