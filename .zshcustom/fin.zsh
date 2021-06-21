export FIN_CODE_HOME="$HOME/code"


# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; else echo rbenv not installed; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init --path)"; eval "$(pyenv virtualenv-init -)"; else echo pyenv not installed; fi

# nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; else echo nodenv not installed; fi

## Needs to come after pyenv init
fa_bin="/usr/local/bin/fa"
test -h $fa_bin ||  ln -s "$FIN_CODE_HOME/fin-dev/fa" $fa_bin
eval "$(_FA_COMPLETE=source_zsh fa)"
