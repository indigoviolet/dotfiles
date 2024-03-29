# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

{% if yadm.os == "Linux" %}
# Brew is in /home/linuxbrew/.linuxbrew on Linux
test -x /home/linuxbrew/.linuxbrew/bin/brew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
{% endif %}

{% if yadm.os == "Darwin" %}
eval $(/opt/homebrew/bin/brew shellenv)

# coreutils, but use non-g-prefixed names
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
{% endif %}

if type brew &>/dev/null; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    zstyle ':completion:*:*:git:*' script $(brew --prefix)/share/zsh/site-functions/git-completion.bash
fi

# export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_GITHUB_API_TOKEN=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
