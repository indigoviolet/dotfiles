# -*- mode: Shell-script -*-
#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#


if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

# export EDITOR='nano'
# export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )


# Set the list of directories that Zsh searches for programs.
#path=(
#  /usr/local/{bin,sbin}
#  $path
# )

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Non-interactive sessions source ~/.zprofile
source ${HOME}/.zshcustom/noninteractive.zsh
# >>> cert-tools (managed) >>>
export REQUESTS_CA_BUNDLE="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
export NODE_EXTRA_CA_CERTS="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
export CURL_CA_BUNDLE="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
export SSL_CERT_FILE="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
export AWS_CA_BUNDLE="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
export CLOUDSDK_CORE_CUSTOM_CA_CERTS_FILE="/opt/local/etc/ssl/certs/os-ca-bundle.pem"
# <<< cert-tools (managed) <<<

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
