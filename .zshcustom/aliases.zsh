# User specific aliases and functions

alias -g sort="sort -S 75%"
alias beep="echo -n '\a'"
alias c="clear"
alias cp="cp -pv"
alias echo="echo -e"

# alias grep="rg"  # breaks on mac os?
alias htop="htop -u $(whoami)"

## Many things don't work well with exa
# alias ls="exa"
# alias ll="exa -l --git"
# alias lt="exa -l -snew --git"

function zshtype {
    # equivalent of `type -t` from bash
    readonly thing=${1:?"zshtype of what?"}
    # > zshtype ll
    # type: alias
    whence -w $thing | awk '{split($0,a,": ");print a[2]}'
}

if [[ $(zshtype l) == 'alias' ]]; then
    unalias l # /home/venky/.zprezto/modules/utility/init.zsh
fi

alias rm="rm -iv"
alias py="ipython"
# alias t="tmux -2 -u -CC a || tmux -2 -u -CC"
alias htopt="htop -p \"$(ps a -o 'pid' | tail -n +2 | perl -0777 -lne 'chop; s/\n/,/g; print')\""
alias find=fd
alias pgrep="pgrep -laf"
alias pkill="pkill -fe"
alias g="git"
