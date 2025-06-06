# User specific aliases and functions

alias sort="sort -S 75%"
alias beep="echo -n '\a'"
alias c="clear"
alias cp="cp -v"
alias echo="echo -e"

# alias grep="rg"  # breaks on mac os?
alias htop="htop -u $(whoami)"

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
# alias py="ipython"
alias py="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
# alias t="tmux -2 -u -CC a || tmux -2 -u -CC"
alias htopt="htop -p \"$(ps a -o 'pid' | tail -n +2 | perl -0777 -lne 'chop; s/\n/,/g; print')\""
# alias find=fd
alias g="git"
# alias cat="bat"
# alias less="bat --paging=always --wrap=never"
# alias z=zi
alias ls="lsd -h -t --date relative --group-dirs=first --blocks size,date,permission,user,name --depth 3 --classify"
alias tree="ls --tree"
alias ll="ls -ltrL"
alias jq="jq -C"
