# Set Path
set PATH ~/.nodebrew/current/bin $PATH
set PATH ~/.scripts $PATH
set PATH ~/Library/Android/sdk/platform-tools $PATH
set PATH ~/Library/Android/sdk/tools $PATH
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

# cd > ls
# TOOD: なれないし'cd -'が使えないから実装が微妙
# function cd
#   builtin cd $argv
#   ls -a
# end

# tmuxを開く設定
function start_tmux
    if command -s tmux > /dev/null
	   tmux -2 new-session
        # if test -z "$TMUX"; and test -z $TERMINAL_CONTEXT
        #     tmux -2 attach; or tmux -2 new-session
        # end
    end
end

start_tmux