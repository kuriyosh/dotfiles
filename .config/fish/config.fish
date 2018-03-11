set PATH ~/.rbenv/shims $PATH
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
. (pyenv init - | psub)
