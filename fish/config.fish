set PATH ~/.nodebrew/current/bin $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/Library/Android/sdk/tools $PATH
# set PATH ~/.rbenv/shims $PATH
# set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
# set -x PATH $HOME/.nodebrew/current/bin $PATH
. (pyenv init - | psub)
. (rbenv init - | psub)
alias rm "rmtrash"
alias emacs "/Applications/Emacs.app/Contents/MacOS/Emacs -nw -q -l ~/.emacs.d/cli.el"

# cd > ls
function cd
  builtin cd $argv
  ls -a
end