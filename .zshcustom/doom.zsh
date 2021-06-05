EMACSDIR=$HOME/.local/doom-emacs
path+=($EMACSDIR/bin)

function doom-tangle-config() {
    emacs --batch -Q --eval "(require 'org)" --eval '(org-babel-tangle-file "'$HOME'/.doom.d/config.org")'
}
