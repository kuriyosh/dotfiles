set PATH ~/.nodebrew/current/bin $PATH
# set PATH ~/.rbenv/shims $PATH
# set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $HOME/.pyenv/bin $PATH
# set -x PATH $HOME/.nodebrew/current/bin $PATH
. (pyenv init - | psub)
alias rm "rmtrash"
# alias emacs "/Applications/Emacs.app/Contents/MacOS/Emacs -nw -q -l ~/.emacs.d/cli.el"
