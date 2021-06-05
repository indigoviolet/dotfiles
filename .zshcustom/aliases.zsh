# User specific aliases and functions
# For iterm-tmux integration
# alias tmux="tmux -CC"

alias -g sort="sort -S 75%"
alias beep="echo -n '\a'"
alias c="clear"
alias cp="cp -pv"
alias echo="echo -e"
# alias grep="rg"  # breaks on mac os?
alias htop="htop -u `whoami`"

## Many things don't work well with exa
# alias ls="exa"
# alias ll="exa -l --git"
# alias lt="exa -l -snew --git"


unalias l                       # /home/venky/.zprezto/modules/utility/init.zsh

alias rm="rm -iv"
alias py="ipython"
alias g="hub"
#alias t="tmux -2 -u -CC a || tmux -2 -u -CC"
alias htopt="htop -p \"$(ps a -o 'pid' | tail -n +2 | perl -0777 -lne 'chop; s/\n/,/g; print')\""
alias find=fd
alias pgrep="pgrep -laf"
alias pkill="pkill -fe"
