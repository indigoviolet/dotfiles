test -x /home/linuxbrew/.linuxbrew/bin/brew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi


function brew-list-used-by () {
    # # https://www.thingy-ma-jig.co.uk/blog/22-09-2014/homebrew-list-packages-and-what-uses-them
    brew list --formula -1 | while read formula; do echo -ne "\x1B[1;34m $formula \x1B[0m"; brew uses $formula --installed --recursive --skip-recommended | awk '{printf(" %s ", $0)}'; echo ""; done
}

function brew-list-dependencies () {
    brew deps -n --installed --for-each
    # # https://www.thingy-ma-jig.co.uk/blog/22-09-2014/homebrew-list-packages-and-what-uses-them
    # brew list -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew deps $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done
}

export HOMEBREW_NO_AUTO_UPDATE=1
