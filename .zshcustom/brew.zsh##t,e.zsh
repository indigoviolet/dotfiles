# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

eval $($HOMEBREW_PREFIX/bin/brew shellenv)

{% if yadm.os == "Darwin" %}
# coreutils, but use non-g-prefixed names
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
{% endif %}

if type brew &>/dev/null; then
    # see https://github.com/oven-sh/bun/issues/1272
    # for now we deleted _bun from site-functions
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    zstyle ':completion:*:*:git:*' script $(brew --prefix)/share/zsh/site-functions/git-completion.bash
fi

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_UPDATE_REPORT_NEW=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
